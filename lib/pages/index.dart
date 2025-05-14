import 'package:demo/constant/app_string.dart';
import 'package:demo/global/index.dart';
import 'package:demo/pages/article/index.dart';
import 'package:demo/pages/bank/index.dart';
import 'package:demo/pages/coterie/page.dart';
import 'package:demo/pages/experiences/index.dart';
import 'package:demo/pages/message/index.dart';
import 'package:demo/pages/user/index.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  // 用于保持每个 tab 页面的状态
  final List<Widget> _pages = [
    CoteriePage(),
    ArticlesPage(),
    ExperiencesPage(),
    BankPage(),
    MessagePage(),
    UserPage(),
  ];

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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent, // 去除点击高亮
          splashColor: Colors.transparent, // 去除点击水波纹
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              tabIndexNotifier.value = index;
            });
          },
          // 圈子、文章、题库、经验、消息、我的
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.group),
              label: AppStrings.coterieTabBarString,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: AppStrings.articlesTabBarString,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: AppStrings.bankTabBarString,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: AppStrings.experiencesTabBarString,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_alert_rounded),
              label: AppStrings.messageTabBarString,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: AppStrings.userTabBarString,
            ),
          ],
        ),
      ),
    );
  }
}
