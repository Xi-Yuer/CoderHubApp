import 'package:demo/constant/app_route_path.dart';
import 'package:demo/pages/home/page.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/pages/my/index.dart';
import 'package:demo/pages/search/index.dart';
import 'package:demo/pages/webView/index.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutePath.index:
      return MaterialPageRoute(builder: (_) => IndexPage());
    case AppRoutePath.home:
      return MaterialPageRoute(builder: (_) => const HomePage("首页"));
    case AppRoutePath.webView:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => WebViewPage(articleItem: args['articleItem']),
      );
    case AppRoutePath.search:
      return MaterialPageRoute(builder: (_) => const SearchPage());
    case AppRoutePath.my:
      return MaterialPageRoute(builder: (_) => const MyPage());
    default:
      return MaterialPageRoute(
        builder:
            (_) => Scaffold(
              appBar: AppBar(title: Text('页面不存在')),
              body: SafeArea(child: Center(child: Text("页面不存在"))),
            ),
      );
  }
}
