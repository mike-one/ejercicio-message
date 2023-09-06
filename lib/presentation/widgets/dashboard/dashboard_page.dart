import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/domain/entities/file_entity.dart';
import 'package:ejercicio_files/presentation/widgets/dashboard/files_scrollable_view.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class DashboardPage extends StatelessWidget {
  final List<FileEntity> files;

  const DashboardPage({super.key, required this.files});

  Widget button() => ProgressButton.icon(iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Envíar",
            icon: const Icon(Icons.send, color: Colors.white),
            color: Colors.deepPurple.shade500),
        ButtonState.loading:
            IconedButton(text: "Enviando", color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
            text: "Falló",
            icon: const Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            text: "Enviado",
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      }, onPressed: () {}, state: ButtonState.idle);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE_SOLID,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FileScrollableView(
            files: files,
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 55,
              right: 20,
            ),
            child: button(),
          ),
        ],
      ),
    );
  }
}
