import 'package:file_picker/file_picker.dart';
import 'package:ejercicio_files/config/helpers/extract_type.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/enums/file_type.dart';

class LocalFileModel {
  final String name;
  final String path;
  final String extension;
  final int size;
  final FileTypeLocal type;
  final String contentType;

  LocalFileModel({
    required this.extension,
    required this.path,
    required this.name,
    required this.type,
    required this.contentType,
    this.size = 0,
  });

  factory LocalFileModel.fromFile(FilePickerResult filePickerResult) =>
      LocalFileModel(
        extension: filePickerResult.files.single.extension ?? '',
        path: filePickerResult.files.single.path.toString(),
        name: filePickerResult.files.single.name.toLowerCase(),
        type: ExtractType.getType(
            filePickerResult.files.single.extension?.toString() ?? ''),
        size: filePickerResult.files.single.size,
        contentType: ExtractType.getContentType(
          filePickerResult.files.single.extension.toString().toLowerCase(),
        ),
      );

  FileEntity toLocalFile() => FileEntity(
        extension: extension,
        path: path,
        name: name,
        type: type,
        size: size,
        contentType: contentType,
      );
}
