import 'package:file_picker/file_picker.dart';
import 'package:ejercicio_files/config/helpers/extract_type.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/enums/file_type.dart';

class LocalFileModel {
  final String name;
  final String path;
  final int size;
  final FileTypeLocal type;

  LocalFileModel({
    required this.path,
    required this.name,
    required this.type,
    this.size = 0,
  });

  factory LocalFileModel.fromFile(FilePickerResult filePickerResult) =>
      LocalFileModel(
        path: filePickerResult.files.single.path.toString(),
        name: filePickerResult.files.single.name,
        type: ExtractType.getType(
            filePickerResult.files.single.extension?.toString() ?? ''),
        size: filePickerResult.files.single.size,
      );

  FileEntity toLocalFile() => FileEntity(
        path: path,
        name: name,
        type: type,
        size: size,
      );
}
