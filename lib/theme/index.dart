import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  // 确保是浅色基调
  brightness: Brightness.light,
  // 主颜色
  primaryColor: Colors.black,
  // 页面背景白色
  scaffoldBackgroundColor: Colors.white,
  // 全局文字样式
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
  ),

  // ElevatedButton 全局样式
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),

  // TextButton 全局样式
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),

  // OutlinedButton 全局样式
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      side: BorderSide(color: Colors.black),
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),

  // AppBar 黑色主题
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  // 滚动条样式
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
);
