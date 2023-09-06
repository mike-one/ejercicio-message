import 'package:ejercicio_files/infraestructure/datasources/local_file_datasource_implements.dart';
import 'package:ejercicio_files/infraestructure/reposiitories/file_datasources_implements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_files/config/theme/app_theme.dart';
import 'package:ejercicio_files/presentation/providers/file_provider.dart';
import 'package:ejercicio_files/presentation/screens/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final fileRepository = FileRepositoryImplements(
    fileDatasource: LocalFileDatasource(),
  );

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
