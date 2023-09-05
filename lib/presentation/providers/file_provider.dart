import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {
  bool isloading = false;
  final fileScrollController = ScrollController();

  FileProvider();
}
