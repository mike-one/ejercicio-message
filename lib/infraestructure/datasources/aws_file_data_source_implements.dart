import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';

class AWSFileDataSourceImplements implements FileDatasource {
  @override
  Future<List<String?>> setNewFiles(List<FileEntity> files) async {
    try {
      final urls = await Future.wait(files.map(
        (file) async {
          final response = await AwsS3.uploadFile(
            accessKey: dotenv.get('ACCESSKEY_AWS', fallback: 'not Found'),
            secretKey: dotenv.get('SECRETKEY_AWS', fallback: 'not Found'),
            file: File(file.path),
            filename: file.name,
            bucket: dotenv.get('BUCKET_NAME', fallback: 'not Found'),
            region: dotenv.get('AWS_REGION', fallback: 'not Found'),
            contentType: file.contentType,
          );
          return response ?? '';
        },
      ).toList());
      return urls;
    } catch (error) {
      print('Errorrrr:$error');
      return [];
    }
  }

  @override
  Future<FileEntity> getNewFile() {
    // TODO: implement getNewFile
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
