import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';
import 'package:ejercicio_files/infraestructure/datasources/aws_file_data_source_implements.dart';
import 'package:ejercicio_files/infraestructure/datasources/local_file_datasource_implements.dart';
import 'package:ejercicio_files/infraestructure/datasources/whatsapp_file_datasource.dart';

class FileProvider extends ChangeNotifier {
  final FileRepository _fileRepository;
  ButtonState _buttonState = ButtonState.idle;
  final _fileScrollController = ScrollController();
  List<FileEntity> _files = [];
  List<String?> _urlFiles = [];
  bool _isloading = false;
  bool _successful = false;
  bool _showMessage = false;

  bool get isLoading => _isloading;

  ButtonState get buttonState => _buttonState;

  ScrollController get fileScrollController => _fileScrollController;

  List<FileEntity> get files => _files;

  bool get showMessage => _showMessage;

  void closeMessage() {
    _showMessage = false;
    notifyListeners();
  }

  FileProvider({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  void showError() {
    _buttonState = ButtonState.fail;
    notifyListeners();
    _updateButton();
  }

  Future<void> loadFile() async {
    _isloading = true;
    notifyListeners();
    FileEntity newFile;

    try {
      if (!await _getPermission(Permission.photos)) return;

      newFile = await _fileRepository.getNewFile(LocalFileDatasource());
      _files.add(newFile);
    } on Exception {
    } catch (error) {
      showError();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  Future<void> uploadFiles() async {
    //Se piden permisos para obtener los contactos
    if (!await _getPermission(Permission.contacts)) return;
    _buttonState = ButtonState.loading;
    notifyListeners();

    try {
      _urlFiles = await _fileRepository.setNewFiles(
        AWSFileDataSourceImplements(),
        _files,
      );
      sendFiles();
    } catch (error) {
      showError();
    } finally {
      notifyListeners();
      _updateButton();
    }
  }

  Future<void> sendFiles() async {
    String? number;

    try {
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();
      number = contact.phoneNumber?.number;
    } catch (error) {
      showError();
      return;
    }

    for (int i = 0; i < _files.length; i++) {
      try {
        await _fileRepository.sendFileFromUrl(
          WhatsAppDatasource(),
          name: _files[i].name,
          file: _urlFiles[i]!,
          extension: _files[i].extension,
          phone: number!.replaceAll(' ', '') ?? '',
        );
        _successful = true;
      } catch (error) {
        showError();
        return;
      }
    }

    _files.clear();
    _buttonState = ButtonState.success;
    notifyListeners();
    _updateButton();
  }

  Future<void> _updateButton() async {
    Future.delayed(const Duration(seconds: 3), () {
      _buttonState = ButtonState.idle;
      _showMessage = _successful;
      _successful = false;
      notifyListeners();
    });
  }

  Future<bool> _getPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
      // Ya tienes permisos, puedes leer archivos aquí.
    } else if (status.isDenied) {
      // Los permisos están denegados, solicita permisos.
      status = await permission.request();
      if (status.isGranted) {
        return true;
        // Permisos otorgados, puedes leer archivos aquí.
      } else {
        return false;
        // Permisos denegados por el usuario, muestra un mensaje.
      }
    }
    return false;
  }
}
