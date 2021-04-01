// * Theme data

import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
      color: Colors.green,
    ),
    brightness: Brightness.light,
    hintColor: Colors.grey[400],
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
      color: Colors.green,
    ),
    brightness: Brightness.dark,
    hintColor: Colors.grey[600],
  );
}
