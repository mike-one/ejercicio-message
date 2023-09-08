import 'package:ejercicio_files/domain/entities/file_entity.dart';

abstract class FileDatasource {
  Future<FileEntity> getNewFile();

  Future<List<String?>> setNewFiles(List<FileEntity> files);

  Future<bool> sendFileFromUrl({
    required String name,
    required String extension,
    required String file,
    String phone = '',
  });
}
