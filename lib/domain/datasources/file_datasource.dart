import 'package:ejercicio_files/domain/entities/file_entity.dart';

abstract class FileDatasource {
  Future<FileEntity> getNewFile();
}
