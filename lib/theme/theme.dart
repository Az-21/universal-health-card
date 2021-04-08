// * Theme data

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
      color: Colors.green,
    ),
    brightness: Brightness.light,
    hintColor: Colors.grey[400],
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        pickerTextStyle: TextStyle(
          color: Colors.black,
        ),
        dateTimePickerTextStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
      color: Colors.green,
    ),
    brightness: Brightness.dark,
    hintColor: Colors.grey[600],
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        pickerTextStyle: TextStyle(
          color: Colors.white,
        ),
        dateTimePickerTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
