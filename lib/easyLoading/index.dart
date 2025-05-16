import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

TransitionBuilder easyLoading() {
  final builder = EasyLoading.init();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blueAccent
    ..backgroundColor = Colors.white.withAlpha(90)
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black87
    ..maskColor = Colors.black.withAlpha(5);

  return builder;
}
