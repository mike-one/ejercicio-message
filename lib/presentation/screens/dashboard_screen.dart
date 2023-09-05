import 'package:ejercicio_files/presentation/widgets/share/files_scrollable_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard

  ({super.key});

  // ignore: non_constant_identifier_names
  Widget _add_icon() =>
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.attach_file),
      );

  Widget _title() =>
      const Text(
        'Agregar archivos',
        style: TextStyle(fontFamily: 'Roboto'),
      );

  @override
  Widget build(BuildContext context) {
    final fileProvider = context.watch<FileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [_add_icon()],
      ),
      body: fileProvider.isloading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : Container(
        color: WHITE_SOLID,
        child: const FileScrollableView(),
      ),
    );
  }
}
