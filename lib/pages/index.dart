import 'package:demo/global/index.dart';
import 'package:demo/pages/home/page.dart';
import 'package:demo/pages/my/index.dart';
import 'package:demo/pages/search/index.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  // 用于保持每个 tab 页面的状态
  final List<Widget> _pages = [HomePage("首页"), SearchPage(), MyPage()];

  @override
  void initState() {
    super.initState();
    tabIndexNotifier.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    tabIndexNotifier.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    setState(() {
      _currentIndex = tabIndexNotifier.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            tabIndexNotifier.value = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
