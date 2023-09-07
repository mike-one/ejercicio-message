import 'package:ejercicio_files/domain/enums/file_type.dart';

class ExtractType {
  static FileTypeLocal getType(String extension) {
    switch (extension) {
      case 'png':
      case 'jpg':
      case 'gif':
        return FileTypeLocal.image;
      case 'pdf':
        return FileTypeLocal.pdf;
      case 'mp4':
      case 'avi':
      case 'mkv':
      case 'mov':
      case 'wmv':
      case 'flv':
      case 'rmvb':
      case 'webm':
      case 'mpeg':
      case 'ogg':
        return FileTypeLocal.video;
      case 'doc':
      case 'txt':
        return FileTypeLocal.document;
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
      case 'ogg':
      case 'm4a':
      case 'wma':
      case 'ape':
      case 'midi':
      case 'mid':
      case 'amr':
        return FileTypeLocal.audio;
      default:
        return FileTypeLocal.other;
    }
  }

  static String getTypeString(String extension) {
    switch (getType(extension).toString().split('.').last) {
      case 'png':
      case 'jpg':
      case 'gif':
        return 'image';
      case 'pdf':
        return 'document';
      case 'mp4':
      case 'avi':
      case 'mkv':
      case 'mov':
      case 'wmv':
      case 'flv':
      case 'rmvb':
      case 'webm':
      case 'mpeg':
      case 'ogg':
        return 'video';
      case 'doc':
      case 'txt':
        return 'document';
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
      case 'ogg':
      case 'm4a':
      case 'wma':
      case 'ape':
      case 'midi':
      case 'mid':
      case 'amr':
        return 'audio';
      default:
        return 'application/$extension';
    }
  }

  static String getContentType(String extension) {
    switch (extension) {
      case 'png':
      case 'jpg':
      case 'gif':
        return 'image/$extension';
      case 'pdf':
        return 'application/$extension';
      case 'mp4':
      case 'avi':
      case 'mkv':
      case 'mov':
      case 'wmv':
      case 'flv':
      case 'rmvb':
      case 'webm':
      case 'mpeg':
      case 'ogg':
        return 'video/$extension';
      case 'doc':
      case 'txt':
        return 'application/$extension';
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
      case 'ogg':
      case 'm4a':
      case 'wma':
      case 'ape':
      case 'midi':
      case 'mid':
      case 'amr':
        return 'audio/$extension';
      default:
        return 'application/$extension';
    }
  }
}
