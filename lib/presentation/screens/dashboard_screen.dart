import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';
import 'package:ejercicio_files/presentation/widgets/dashboard/dashboard_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  Future<void> _onPress(FileProvider fileProvider) async {
    await fileProvider.loadFile();
  }

  // ignore: non_constant_identifier_names
  Widget _add_icon(FileProvider fileProvider) => IconButton(
        onPressed: () => _onPress(fileProvider),
        icon: const Icon(Icons.attach_file),
      );

  Widget _title() => const Text(
        'Agregar archivos',
        style: TextStyle(fontFamily: 'Roboto'),
      );

  @override
  Widget build(BuildContext context) {
    final fileProvider = context.watch<FileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [_add_icon(fileProvider)],
      ),
      body: fileProvider.isloading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : DashboardPage(
              files: fileProvider.files,
            ),
    );
  }
}
