import 'package:ejercicio_files/domain/enums/file_type.dart';

class FileEntity {
  final String extension;
  final String name;
  final String path;
  final int size;
  final FileTypeLocal type;
  final String contentType;

  FileEntity({
    required this.path,
    required this.name,
    required this.type,
    required this.contentType,
    this.extension = '',
    this.size = 0,
  });
}
