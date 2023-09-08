import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image/image.dart' as img;
import 'package:video_compress/video_compress.dart';
import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:ejercicio_files/config/helpers/extract_type.dart';
import 'package:ejercicio_files/domain/datasources/file_datasource.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';

class AWSFileDataSourceImplements implements FileDatasource {
  @override
  Future<List<String?>> setNewFiles(List<FileEntity> files) async {
    try {
      final urls = await Future.wait(files.map(
        (file) async {
          final fileEncoded = await _encode(file.path, file.extension);
          final response = await AwsS3.uploadFile(
            accessKey: dotenv.get('ACCESSKEY_AWS', fallback: 'not Found'),
            secretKey: dotenv.get('SECRETKEY_AWS', fallback: 'not Found'),
            file: File(fileEncoded),
            filename: fileEncoded.split('/').last,
            bucket: dotenv.get('BUCKET_NAME', fallback: 'not Found'),
            region: dotenv.get('AWS_REGION', fallback: 'not Found'),
            contentType: file.contentType,
          );
          return response ?? '';
        },
      ).toList());
      return urls;
    } catch (error) {
      return [];
    }
  }

  Future<String> _encode(String path, String extension) async {
    switch (ExtractType.getTypeString(extension)) {
      case 'image':
        if (extension == 'jpeg' || extension == 'png') return path;
        return await _encodeImagen(path);
      case 'video':
        if (extension == 'mp4' || extension == '3gpp') return path;
        return await _encodeVideoAudio(path);
      case 'audio':
        if (extension == 'aac' ||
            extension == 'mp4' ||
            extension == 'amr' ||
            extension == 'mpeg' ||
            extension == 'gg' ||
            extension == 'opus') {
          return path;
        }
        return await _encodeVideoAudio(path, isVideo: false);
      case 'document':
      default:
        return path;
    }
  }

  Future<String> _encodeVideoAudio(String inputPath,
      {bool isVideo = true}) async {
    await VideoCompress.setLogLevel(0);
    try {
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        inputPath,
        quality: VideoQuality.Res640x480Quality,
        deleteOrigin: false, // It's false by default
      );
      return mediaInfo!.path!;
    } catch (error) {
      return inputPath;
    }
  }

  Future<String> _encodeImagen(String inputPath) async {
    // Ruta del video de salida
    final tempDir = await Directory.systemTemp.createTemp('images');
    String outputPath = '${tempDir.path}/image.jpeg';
    try {
      File inputFile = File(inputPath);
      List<int> bytes = inputFile.readAsBytesSync();
      img.Image imagen = img.decodeImage(Uint8List.fromList(bytes))!;
      File(outputPath)
        ..writeAsBytesSync(
          img.encodeJpg(imagen),
        );
      return outputPath;
    } on Exception {
      return inputPath;
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
