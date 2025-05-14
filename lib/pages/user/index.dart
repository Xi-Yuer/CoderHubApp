import 'package:demo/global/index.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
