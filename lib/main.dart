import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/infraestructure/reposiitories/file_datasources_implements.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';
import 'package:ejercicio_files/presentation/screens/dashboard_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final fileRepository = FileRepositoryImplements();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => FileProvider(fileRepository: fileRepository),
        ),
      ],
      child: MaterialApp(
          title: 'Files',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().getTheme(),
          home: const Dashboard()),
    );
  }
}
