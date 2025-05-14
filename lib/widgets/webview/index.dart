import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPageWidget extends StatefulWidget {
  final String url;

  const WebViewPageWidget({super.key, required this.url});

  @override
  State<WebViewPageWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPageWidget> {
  late InAppWebViewController webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          progress < 1.0
              ? LinearProgressIndicator(
                // 当前进度
                value: progress,
                // 进度条颜色
                color: Colors.black,
                // 进度条背景颜色
                backgroundColor: Colors.white,
              )
              : const SizedBox(height: 0),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onProgressChanged: (controller, p) {
                setState(() {
                  progress = p / 100;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
