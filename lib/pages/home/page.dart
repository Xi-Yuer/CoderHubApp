import 'package:demo/constant/app_route_path.dart';
import 'package:demo/widgets/banner/index.dart';
import 'package:demo/widgets/card/index.dart';
import 'package:demo/request/api/index.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage(String title, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<CardCom> articleList = [];
  int page = 1;

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _getBanner();
  }

  Future<void> _getBanner() async {
    var articleListResponse = await getArticleList(page);
    if (mounted) {
      setState(() {
        if (articleListResponse != null && articleListResponse.isNotEmpty) {
          articleList.addAll(
            List.generate(
              articleListResponse.length,
              (index) => CardCom(data: articleListResponse[index]),
            ),
          );
        }
      });
    }
  }

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      setState(() {
        setState(() {
          articleList.clear();
          page = 1;
          _getBanner();
        });
      });
      _refreshController.refreshCompleted(); // 结束刷新状态
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      setState(() {
        page++;
        _getBanner();
      });
      _refreshController.loadNoData();
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          header: ClassicHeader(
            idleText: '下拉可以刷新',
            refreshingText: '正在刷新中...',
            completeText: '刷新完成',
            failedText: '刷新失败',
            releaseText: '松手立即刷新',
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              switch (mode) {
                case LoadStatus.idle:
                  body = Text("上拉加载更多");
                  break;
                case LoadStatus.loading:
                  body = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 10),
                      Text("正在加载中…"),
                    ],
                  );
                  break;
                case LoadStatus.failed:
                  body = Text("加载失败，请重试");
                  break;
                case LoadStatus.canLoading:
                  body = Text("松开立即加载");
                  break;
                case LoadStatus.noMore:
                  body = Text("没有更多内容了");
                  break;
                default:
                  body = Container();
              }
              return SizedBox(height: 55.0, child: Center(child: body));
            },
          ),
          onRefresh: _onRefresh,
          enablePullUp: true,
          controller: _refreshController,
          onLoading: _onLoading,
          child: ListView.builder(
            // shrinkWrap: true, // 开启自动计算高度
            // physics: NeverScrollableScrollPhysics(), // 禁用滑动
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return BannerCom();
              }
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 0,
                ),
                child: articleList[index],
              );
            },
            itemCount: articleList.length,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, AppRoutePath.index);
              break;
            case 1:
              Navigator.pushNamed(context, AppRoutePath.search);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutePath.my);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
