import 'package:ejercicio_files/domain/file_type.dart';

class FileEntity {
  final String name;
  final String path;
  final int size;
  final FileType type;

  FileEntity({
    required this.path,
    required this.name,
    required this.type,
    this.size = 0,
  });
}
