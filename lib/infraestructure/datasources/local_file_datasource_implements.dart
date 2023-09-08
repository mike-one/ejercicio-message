import 'package:file_picker/file_picker.dart';
import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/infraestructure/models/local_file_model.dart';

class LocalFileDatasource implements FileDatasource {
  @override
  Future<FileEntity> getNewFile() async {
    // Select a file from the device
    FilePickerResult? result;

    try {
      result = await FilePicker.platform.pickFiles();
    } catch (error) {
      throw Exception('error');
    }
    if (result != null) {
      return LocalFileModel.fromFile(result).toLocalFile();
    } else {
      throw Exception('cancelled');
    }
  }

  @override
  Future<List<String?>> setNewFiles(List<FileEntity> files) {
    // TODO: implement setNewFiles
    throw UnimplementedError();
  }

  @override
  Future<bool> sendFileFromUrl({
    required String name,
    required String extension,
    required String file,
    String phone = '',
  }) {
    // TODO: implement sendFileFromUrl
    throw UnimplementedError();
  }
}
