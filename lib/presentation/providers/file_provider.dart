import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';
import 'package:ejercicio_files/infraestructure/datasources/aws_file_data_source_implements.dart';
import 'package:ejercicio_files/infraestructure/datasources/local_file_datasource_implements.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_state_button/progress_button.dart';

class FileProvider extends ChangeNotifier {
  bool isloading = false;
  ButtonState buttonState = ButtonState.idle;
  final fileScrollController = ScrollController();
  final FileRepository fileRepository;
  List<FileEntity> files = [];

  FileProvider({required this.fileRepository});

  Future<void> loadFile() async {
    isloading = true;
    notifyListeners();
    FileEntity newFile;
    try {
//      if (!await getPermission()) return;
      newFile = await fileRepository.getNewFile(LocalFileDatasource());
      files.add(newFile);
    } catch (error) {
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> uploadFiles() async {
    buttonState = ButtonState.loading;
    notifyListeners();
    try {
      final response = await fileRepository.setNewFiles(
        AWSFileDataSourceImplements(),
        files,
      );
      response.forEach((element) {
        print(element);
      });
      files.clear();
      buttonState = ButtonState.success;
    } catch (error) {
      buttonState = ButtonState.fail;
    } finally {
      notifyListeners();
      updateButton();
    }
  }

  Future<void> updateButton() async {
    Future.delayed(const Duration(seconds: 3), () {
      buttonState = ButtonState.idle;
      notifyListeners();
    });
  }

  Future<bool> getPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
      // Ya tienes permisos, puedes leer archivos aquí.
    } else if (status.isDenied) {
      // Los permisos están denegados, solicita permisos.
      status = await Permission.storage.request();
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
