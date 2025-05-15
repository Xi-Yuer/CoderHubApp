import 'package:demo/constant/app_route_path.dart';
import 'package:demo/constant/app_string.dart';
import 'package:demo/request/api/index.dart';
import 'package:demo/request/models/tag.dart';
import 'package:demo/widgets/banner/index.dart';
import 'package:demo/widgets/card/index.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoteriePage extends StatefulWidget {
  const CoteriePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoteriePageState();
  }
}

class _CoteriePageState extends State<CoteriePage> {
  List<CardCom> articleList = [];
  List<TagItem> tagList = [];
  int page = 1;
  int _selectedTagIndex = 0;

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _getBanner();
    _getTagList();
  }

  Future<bool> _getBanner() async {
    var articleListResponse = await getArticleList(AppStrings.article, page);
    if (!mounted) return false;

    if (articleListResponse != null && articleListResponse.isNotEmpty) {
      setState(() {
        articleList.addAll(
          List.generate(
            articleListResponse.length,
            (index) => CardCom(data: articleListResponse[index]),
          ),
        );
      });
      return true; // 表示还有数据
    } else {
      return false; // 表示没有更多数据
    }
  }

  Future _getTagList() async {
    var tagListResponse = await getTagList(AppStrings.article);
    if (!mounted) return;

    if (tagListResponse!.isNotEmpty) {
      setState(() {
        tagList = tagListResponse;
      });
    }
  }

  void _onRefresh() async {
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
    if (mounted) {
      page++;
      bool hasMore = await _getBanner();
      if (hasMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        surfaceTintColor: Colors.white, // 顶部背景色
        shadowColor: Colors.white70, // 顶部阴影颜色
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutePath.search);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SmartRefresher(
          header: buildClassicHeader(),
          footer: buildCustomFooter(),
          onRefresh: _onRefresh,
          enablePullUp: true,
          controller: _refreshController,
          onLoading: _onLoading,
          child: ListView(
            children: [
              BannerCom(),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  itemCount: tagList.length,
                  itemBuilder: (context, index) {
                    final tag = tagList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTagIndex = index;
                          // TODO: 根据 tag.id 加载过滤后的文章列表
                        });
                      },
                      child: _buildTabItem(tag, _selectedTagIndex == index),
                    );
                  },
                ),
              ),
              ...articleList.map(
                (article) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 0,
                  ),
                  child: article,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomFooter buildCustomFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        switch (mode) {
          case LoadStatus.idle:
            body = Text(AppStrings.loadMore);
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
                Text(AppStrings.loadMoreLoading),
              ],
            );
            break;
          case LoadStatus.failed:
            body = Text(AppStrings.loadMoreFailed);
            break;
          case LoadStatus.canLoading:
            body = Text(AppStrings.releaseToRefresh);
            break;
          case LoadStatus.noMore:
            body = Text(AppStrings.loadMoreNoMore);
            break;
          default:
            body = Container();
        }
        return SizedBox(height: 55.0, child: Center(child: body));
      },
    );
  }

  ClassicHeader buildClassicHeader() {
    return ClassicHeader(
      idleText: AppStrings.pullToRefresh,
      refreshingText: AppStrings.refreshing,
      completeText: AppStrings.refreshComplete,
      failedText: AppStrings.refreshFailed,
      releaseText: AppStrings.releaseToRefresh,
    );
  }
}

Widget _buildTabItem(TagItem tag, bool isSelected) {
  return Container(
    margin: EdgeInsets.only(right: 20, bottom: 0),
    padding: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      // 底部边框
      border: Border(
        bottom: BorderSide(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 2,
        ),
      ),
    ),
    child: Text(
      tag.name,
      style: TextStyle(
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}
