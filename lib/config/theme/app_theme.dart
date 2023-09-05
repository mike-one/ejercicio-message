// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      );
}

const WHITE_SOLID = Color(0xFFFFFFFF);
const BLACK_SOLID = Color(0xFF000000);
const BLACK_LIGHT = Color(0x1F000000);
const LIGHT_GRAY = Color(0x22616C93);
