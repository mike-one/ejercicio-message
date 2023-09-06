import 'package:flutter/material.dart';
import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/domain/enums/file_type.dart';

class ItemFile extends StatelessWidget {
  final FileEntity file;

  const ItemFile({super.key, required this.file});

  String _image() {
    switch (file.type) {
      case FileTypeLocal.image:
        return 'assets/icons/image.png';
      case FileTypeLocal.pdf:
        return 'assets/icons/pdf.png';
      case FileTypeLocal.video:
        return 'assets/icons/video.png';
      case FileTypeLocal.doc:
        return 'assets/icons/doc.png';
      case FileTypeLocal.audio:
        return 'assets/icons/audio.png';
      case FileTypeLocal.other:
      default:
        return 'assets/icons/image.png';
    }
  }

  Widget _iconSource() => Image.asset(_image());

  Widget _name() => Center(
        child: Text(
          file.name,
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: BLACK_SOLID,
          ),
        ),
      );

  Widget _delete() => SizedBox(
      height: 40,
      child: IconButton(
        onPressed: () {},
        icon: Image.asset('assets/icons/trash.png'),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 80,
        child: Card(
          color: BLACK_LIGHT,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: _iconSource(),
              ),
              Expanded(
                flex: 3,
                child: _name(),
              ),
              Expanded(
                flex: 1,
                child: _delete(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
