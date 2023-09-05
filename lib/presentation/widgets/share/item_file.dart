import 'package:ejercicio_files/domain/file_entity.dart';
import 'package:ejercicio_files/domain/file_type.dart';
import 'package:flutter/cupertino.dart';

class ItemFile extends StatelessWidget {
  FileEntity file;

  ItemFile({super.key, required this.file});

  String _image() {
    switch (file.type) {
      case FileType.image:
        return '';
      case FileType.pdf:
        return '';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: const SizedBox(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Placeholder(),
              flex: 1,
            ),
            Expanded(
              child: Placeholder(),
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
