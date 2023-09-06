import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileProvider extends ChangeNotifier {
  bool isloading = false;
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
      newFile = await fileRepository.getNewFile();
      print('Lo leyó');
      print(newFile.name);
      print(newFile.path);
      files.add(newFile);
    } catch (error) {
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<bool> getPermission() async {
    PermissionStatus status = await Permission.storage.status;
    print('Status: $status');
    if (status.isGranted) {
      return true;
      // Ya tienes permisos, puedes leer archivos aquí.
    } else if (status.isDenied) {
      // Los permisos están denegados, solicita permisos.
      status = await Permission.storage.request();
      print('Segundfo inento:$status');
      if (status.isGranted) {
        return true;
        // Permisos otorgados, puedes leer archivos aquí.
      } else {
//        openAppSettings();
        return false;
        // Permisos denegados por el usuario, muestra un mensaje.
      }
    }
    return false;
  }
}
