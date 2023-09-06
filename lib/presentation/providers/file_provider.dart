import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';
import 'package:flutter/material.dart';

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
      newFile = await fileRepository.getNewFile();
      files.add(newFile);
    } catch (error) {
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
