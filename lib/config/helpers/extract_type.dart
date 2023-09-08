import 'package:ejercicio_files/domain/enums/file_type.dart';

/**
 * audio: acc, mp4, amr, mpeg, ogg
 * video mp4, 3gpp
 */

class ExtractType {
  static FileTypeLocal getType(String extension) {
    switch (extension) {
      case 'png':
      case 'jpg':
      case 'gif':
      case 'jpeg':
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
    switch (getType(extension)) {
      case FileTypeLocal.image:
        return 'image';
      case FileTypeLocal.video:
        return 'video';
      case FileTypeLocal.audio:
        return 'audio';
      case FileTypeLocal.pdf:
      case FileTypeLocal.document:
      case FileTypeLocal.other:
      default:
        return 'document';
    }
  }

  static String getContentType(String extension) {
    final ext = getTypeString(extension);
    switch (ext) {
      case 'image':
        return 'image/$extension';
      case 'document':
        return 'application/$extension';
      case 'video':
        return 'video/${(extension != 'mp4' && extension != '3gpp') ? 'mp4' : extension}';
      case 'audio':
        return 'audio/$extension';
      default:
        return 'application/$extension';
    }
  }
}
