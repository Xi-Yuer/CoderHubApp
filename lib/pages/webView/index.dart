import 'package:demo/request/models/articles.dart';
import 'package:demo/widgets/webview/index.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final ArticleItem articleItem;

  const WebViewPage({super.key, required this.articleItem});

  @override
  State<StatefulWidget> createState() {
    return _WebViewStatePage();
  }
}

class _WebViewStatePage extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.articleItem.article.title)),
      body: SafeArea(
        child: WebViewPageWidget(
          url: "https://xiyuer.club/post/${widget.articleItem.article.id}",
        ),
      ),
    );
  }
}
