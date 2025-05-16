import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.blue), // 主题色
);

class AppTheme {
  static final primaryColor = Colors.blue;
  static final primaryColorWithAlpha = Colors.blue.withAlpha(90);
  static final activeTextColor = Colors.black;
  static final inactiveTextColor = Colors.black.withAlpha(90);
  static final linearGradientLeftTop = Color(0xFFF6F9FF);
  static final linearGradientRightBottom = Color(0xFFF6F9FF);
}