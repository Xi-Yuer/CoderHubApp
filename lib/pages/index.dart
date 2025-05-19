import 'dart:ui';

import 'package:demo/constant/app_route_path.dart';
import 'package:demo/constant/app_string.dart';
import 'package:demo/global/index.dart';
import 'package:demo/pages/article/index.dart';
import 'package:demo/pages/bank/index.dart';
import 'package:demo/pages/coterie/index.dart';
import 'package:demo/pages/experiences/index.dart';
import 'package:demo/pages/message/index.dart';
import 'package:demo/pages/user/index.dart';
import 'package:demo/theme/index.dart';
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
    ArticlePage(),
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

  Widget _buildTabIcon(
    int index,
    IconData icon,
    String label, {
    int? badge = 0,
  }) {
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  TweenAnimationBuilder<Color?>( // 动画效果: 选中时颜色变化
                    tween: ColorTween(
                      begin: AppTheme.inactiveTextColor,
                      end: isSelected ? AppTheme.primaryColor : AppTheme
                          .inactiveTextColor,
                    ),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, color, child) {
                      return Icon(
                        icon,
                        size: 20,
                        color: color,
                      );
                    },
                  ),
                  if (badge != null && badge > 0)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: ClipOval(
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(color: Colors.red),
                          child: Center(
                            child: Text(
                              badge > 99 ? '99+' : '$badge',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: AppTheme.inactiveTextColor,
                  end: isSelected ? AppTheme.primaryColor : AppTheme
                      .inactiveTextColor,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, color, child) {
                  return Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                    ),
                  );
                },
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
      appBar: buildAppBar(),
      body: buildBodyContainer(),
      floatingActionButton: buildCreatorContainer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationClipRect(),
    );
  }

  ClipRect buildBottomNavigationClipRect() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), //  模糊程度
        child: BottomAppBar(
          color: AppTheme.primaryColor.withAlpha(10),
          // 半透明背景，产生磨砂感
          shape: const CircularNotchedRectangle(),
          // 底部导航栏的形状
          notchMargin: 10,
          elevation: 0,
          //  去除默认阴影，视觉更纯粹
          child: Row(
            children: [
              _buildTabIcon(0, Icons.group, AppStrings.coterieTabBarString),
              _buildTabIcon(1, Icons.article, AppStrings.articlesTabBarString),
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
                badge: 3,
              ),
              _buildTabIcon(5, Icons.person, AppStrings.userTabBarString),
            ],
          ),
        ),
      ),
    );
  }

  Container buildBodyContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.linearGradientLeftTop,
            AppTheme.linearGradientRightBottom,
          ],
        ),
      ),
      child: IndexedStack(index: _currentIndex, children: _pages),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        AppStrings.appName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      elevation: 0, // 去除默认阴影
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.linearGradientLeftTop,
              AppTheme.linearGradientRightBottom,
            ],
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
        color: AppTheme.primaryColor,
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
          Navigator.pushNamed(context, AppRoutePath.creator);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
