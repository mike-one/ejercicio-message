import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';

class SuccessfulView extends StatelessWidget {
  const SuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = context.watch<FileProvider>();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: GREEN_SUCCESSFUL,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/successful.png',
                  height: 200, // Puedes ajustar el tamaño de la imagen aquí.
                ),
              ),
              const SizedBox(height: 80),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    fileProvider.closeMessage();
                    // Acción cuando se presiona el botón.
                  },
                  child: const Text(
                    'ACEPTAR',
                    style: TextStyle(color: GREEN_SUCCESSFUL),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
