import 'package:demo/constant/app_route_path.dart';
import 'package:demo/easyLoading/index.dart';
import 'package:demo/provider/index.dart';
import 'package:demo/route/index.dart';
import 'package:demo/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global/index.dart';

class App extends StatelessWidget {
  final String title;

  const App({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: title,
        theme: themeData,
        initialRoute: AppRoutePath.index,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: navigatorKey,
        builder: easyLoading(),
      ),
    );
  }
}
