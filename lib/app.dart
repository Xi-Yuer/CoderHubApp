import 'package:demo/constant/app_route_path.dart';
import 'package:demo/provider/index.dart';
import 'package:demo/route/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App(String title, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        ),
        initialRoute: AppRoutePath.index,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: GlobalKey(),
        // home: const HomePage('Flutter Demo Home Page'),
      ),
    );
  }
}
