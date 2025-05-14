import 'package:demo/constant/app_route_path.dart';
import 'package:demo/constant/app_string.dart';
import 'package:demo/pages/article/index.dart';
import 'package:demo/pages/bank/index.dart';
import 'package:demo/pages/coterie/page.dart';
import 'package:demo/pages/experiences/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/pages/message/index.dart';
import 'package:demo/pages/user/index.dart';
import 'package:demo/pages/webView/index.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  AppRoutePath.index: (_) => IndexPage(),
  AppRoutePath.coterie: (_) => const CoteriePage(),
  AppRoutePath.article: (_) => const ArticlesPage(),
  AppRoutePath.experiences: (_) => const ExperiencesPage(),
  AppRoutePath.bank: (_) => const BankPage(),
  AppRoutePath.message: (_) => const MessagePage(),
  AppRoutePath.my: (_) => const UserPage(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final dynamicRoute = _handleDynamicRoutes(settings);
  if (dynamicRoute != null) return dynamicRoute;

  final builder = routes[settings.name];
  if (builder != null) {
    return MaterialPageRoute(builder: builder);
  }

  return MaterialPageRoute(
    builder:
        (_) => Scaffold(
          appBar: AppBar(title: Text(AppStrings.pageNotFond)),
          body: SafeArea(child: Center(child: Text(AppStrings.pageNotFond))),
        ),
  );
}

Route<dynamic>? _handleDynamicRoutes(RouteSettings settings) {
  if (settings.name == AppRoutePath.webView) {
    final args = settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('articleItem')) {
      return MaterialPageRoute(
        builder: (_) => WebViewPage(articleItem: args['articleItem']),
      );
    }
  }
  return null;
}
