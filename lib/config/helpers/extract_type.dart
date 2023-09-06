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
        return FileTypeLocal.doc;
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
}
