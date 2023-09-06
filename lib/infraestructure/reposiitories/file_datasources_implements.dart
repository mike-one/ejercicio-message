import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/repositories/file_repository.dart';

class FileRepositoryImplements implements FileRepository {
  final FileDatasource fileDatasource;

  FileRepositoryImplements({required this.fileDatasource});

  @override
  Future<FileEntity> getNewFile() {
    return fileDatasource.getNewFile();
  }
}
