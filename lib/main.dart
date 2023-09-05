import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';
import 'package:ejercicio_files/presentation/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => FileProvider()),
      ],
      child: MaterialApp(
          title: 'Files',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().getTheme(),
          home: const Dashboard()),
    );
  }
}
