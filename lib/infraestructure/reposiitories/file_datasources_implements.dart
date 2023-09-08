import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';

class FileRepositoryImplements implements FileRepository {
  @override
  Future<FileEntity> getNewFile(FileDatasource fileDatasource) {
    return fileDatasource.getNewFile();
  }

  @override
  Future<List<String?>> setNewFiles(
    FileDatasource fileDatasource,
    List<FileEntity> files,
  ) {
    return fileDatasource.setNewFiles(files);
  }

  @override
  Future<bool> sendFileFromUrl(
    FileDatasource fileDatasource, {
    required String name,
    required String extension,
    required String file,
    String phone = '',
  }) {
    return fileDatasource.sendFileFromUrl(
      name: name,
      extension: extension,
      file: file,
      phone: phone,
    );
  }
}
