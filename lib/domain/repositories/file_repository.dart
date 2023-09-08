import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';

abstract class FileRepository {
  Future<FileEntity> getNewFile(FileDatasource fileDatasource);

  Future<List<String?>> setNewFiles(
      FileDatasource fileDatasource, List<FileEntity> files);

  Future<bool> sendFileFromUrl(
    FileDatasource fileDatasource, {
    required String name,
    required String file,
    required String extension,
    String phone = '',
  });
}
