import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';
import 'package:ejercicio_files/presentation/widgets/dashboard/item_file.dart';

class FileScrollableView extends StatelessWidget {
  const FileScrollableView({super.key, required this.files});

  final List<FileEntity> files;

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
          itemCount: files.length,
          itemBuilder: (context, index) {
            return ItemFile(
              file: files[index],
            );
          },
        ),
      ),
    );
  }
}
