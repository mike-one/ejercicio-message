import 'package:ejercicio_files/domain/entities/file_entity.dart';

abstract class FileRepository {
  Future<FileEntity> getNewFile();
}
