import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';
import 'package:ejercicio_files/infraestructure/datasources/aws_file_data_source_implements.dart';
import 'package:ejercicio_files/infraestructure/datasources/local_file_datasource_implements.dart';
import 'package:ejercicio_files/infraestructure/datasources/whatsapp_file_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_state_button/progress_button.dart';

class FileProvider extends ChangeNotifier {
  bool isloading = false;
  ButtonState buttonState = ButtonState.idle;
  final fileScrollController = ScrollController();
  final FileRepository fileRepository;
  List<FileEntity> files = [];
  List<String?> urlFiles = [];

  FileProvider({required this.fileRepository});

  Future<void> loadFile() async {
    isloading = true;
    notifyListeners();
    FileEntity newFile;
    try {
      if (!await getPermission(Permission.photos)) return;
      newFile = await fileRepository.getNewFile(LocalFileDatasource());
      print('newFile: ${newFile.name}');
      files.add(newFile);
    } catch (error) {
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> uploadFiles() async {
    //Se piden permisos para obtener los contactos
    if (!await getPermission(Permission.contacts)) return;
    buttonState = ButtonState.loading;
    isloading = true;
    notifyListeners();
    try {
      urlFiles = await fileRepository.setNewFiles(
        AWSFileDataSourceImplements(),
        files,
      );
      urlFiles.forEach(
        (element) {
          print('element:$element');
        },
      );
      isloading = false;
      sendFiles();
    } catch (error) {
      buttonState = ButtonState.fail;
    } finally {
      notifyListeners();
      updateButton();
    }
  }

  Future<void> sendFiles() async {
    String? number;
    try {
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();
      number = contact.phoneNumber?.number;
    } catch (error) {
      buttonState = ButtonState.fail;
      notifyListeners();
      updateButton();
      return;
    }

    print('number: $number');
    for (int i = 0; i < files.length; i++) {
      try {
        await fileRepository.sendFileFromUrl(
          WhatsAppDatasource(),
          name: files[i].name,
          file: urlFiles[i]!,
          extension: files[i].extension,
          phone: number!.replaceAll(' ', '') ?? '',
        );
      } catch (error) {}
    }
    files.clear();
    buttonState = ButtonState.success;
    notifyListeners();
    updateButton();
  }

  Future<void> updateButton() async {
    Future.delayed(const Duration(seconds: 3), () {
      buttonState = ButtonState.idle;
      notifyListeners();
    });
  }

  Future<bool> getPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
      // Ya tienes permisos, puedes leer archivos aquí.
    } else if (status.isDenied) {
      // Los permisos están denegados, solicita permisos.
      status = await permission.request();
      print('Permisos:$status');
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
