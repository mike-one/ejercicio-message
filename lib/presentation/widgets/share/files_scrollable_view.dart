import 'package:ejercicio_files/domain/file_entity.dart';
import 'package:ejercicio_files/domain/file_type.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';
import 'package:ejercicio_files/presentation/widgets/share/item_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FileScrollableView extends StatelessWidget {
  const FileScrollableView({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = context.watch<FileProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ListView.builder(
          controller: fileProvider.fileScrollController,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ItemFile(
              file: FileEntity(
                path: '',
                name: 'nombre',
                type: FileType.pdf,
              ),
            );
          },
        ),
      ),
    );
  }
}
