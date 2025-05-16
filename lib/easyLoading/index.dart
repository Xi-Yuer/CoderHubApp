import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

TransitionBuilder easyLoading() {
  TransitionBuilder easyLoading = EasyLoading.init();
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000) // 展示时间，默认2000ms
    ..indicatorType =
        EasyLoadingIndicatorType
            .fadingCircle // 默认加载样式
    ..loadingStyle =
        EasyLoadingStyle
            .dark // 默认加载样式
    ..indicatorSize =
        45.0 // 默认指示器大小
    ..radius =
        10.0 // 默认指示器大小
    ..progressColor =
        Colors
            .yellow // 进度条颜色
    ..backgroundColor =
        Colors
            .green // 背景颜色
    ..indicatorColor =
        Colors
            .yellow // 默认指示器颜色
    ..textColor =
        Colors
            .yellow // 文字颜色
    ..maskColor = Colors.blue.withAlpha(5); // 遮罩颜色

  return easyLoading;
}
