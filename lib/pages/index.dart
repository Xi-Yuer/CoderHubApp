import 'dart:ui';

import 'package:demo/constant/app_route_path.dart';
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

  Widget _buildTabIcon(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            tabIndexNotifier.value = index;
          });
        },
        child: SizedBox(
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.black : Colors.grey,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButton: buildCreatorContainer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), //  模糊程度
          child: BottomAppBar(
            color: Colors.black12.withAlpha(10),
            // 半透明背景，产生磨砂感
            shape: const CircularNotchedRectangle(),
            // 底部导航栏的形状
            notchMargin: 10,
            elevation: 0,
            //  去除默认阴影，视觉更纯粹
            child: Row(
              children: [
                _buildTabIcon(0, Icons.group, AppStrings.coterieTabBarString),
                _buildTabIcon(
                  1,
                  Icons.article,
                  AppStrings.articlesTabBarString,
                ),
                _buildTabIcon(
                  2,
                  Icons.explore,
                  AppStrings.experiencesTabBarString,
                ),
                const SizedBox(width: 48),
                _buildTabIcon(3, Icons.lightbulb, AppStrings.bankTabBarString),
                _buildTabIcon(
                  4,
                  Icons.add_alert_rounded,
                  AppStrings.messageTabBarString,
                ),
                _buildTabIcon(5, Icons.person, AppStrings.userTabBarString),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildCreatorContainer() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        onPressed: () {
          // 跳转创作页
          Navigator.pushNamed(context, AppRoutePath.creator);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
