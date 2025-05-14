import 'package:demo/global/index.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('我的'),
            ElevatedButton(
              onPressed: () {
                tabIndexNotifier.value = 1; // 切换到搜索页
                Navigator.popUntil(context, (route) => route.isFirst); // 跳转到首页
              },
              child: const Text('跳转到搜索页'),
            ),
          ],
        ),
      ),
    );
  }
}
