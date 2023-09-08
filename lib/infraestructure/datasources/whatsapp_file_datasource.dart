import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:ejercicio_files/config/helpers/extract_type.dart';
import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';

class WhatsAppDatasource implements FileDatasource {
  final dio = Dio();

  @override
  Future<FileEntity> getNewFile() {
    // TODO: implement getNewFile
    throw UnimplementedError();
  }

  @override
  Future<bool> sendFileFromUrl({
    required String name,
    required String file,
    required String extension,
    String phone = '',
  }) async {
    try {
      final data = _getJson(
        name: name,
        file: file,
        extension: extension,
        phone: phone,
      );
      await dio.post(
        'https://waba-v2.360dialog.io/messages',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'D360-API-KEY': dotenv.get(
              'ACCESSKEY_360',
              fallback: 'not Found',
            )
          },
        ),
        data: data,
      );
      return true;
    } catch (error) {}
    return false;
  }

  Map<String, dynamic> _getJson({
    required String name,
    required String file,
    required String extension,
    required String phone,
  }) {
    Map<String, dynamic> json = {
      'messaging_product': 'whatsapp',
      'to': phone,
      'recipient_type': 'individual',
      'type': ExtractType.getTypeString(extension)
    };
    Map<String, dynamic> content = {'link': file};
    switch (ExtractType.getTypeString(extension)) {
      case 'audio':
        json['audio'] = content;
        break;
      case 'video':
        content['caption'] = name;
        json['video'] = content;
        break;
      case 'document':
        content['caption'] = name;
        json['document'] = content;
        break;
      case 'image':
        json['image'] = content;
        break;
      case 'pdf':
        content['caption'] = name;
        json['document'] = content;
        break;
      default:
        content['caption'] = name;
        json['document'] = content;
        break;
    }

    return json;
  }

  @override
  Future<List<String?>> setNewFiles(List<FileEntity> files) {
    // TODO: implement setNewFiles
    throw UnimplementedError();
  }
}
