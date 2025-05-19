import 'package:demo/constant/app_string.dart';
import 'package:demo/request/api/index.dart';
import 'package:demo/request/models/tag.dart';
import 'package:demo/widgets/banner/index.dart';
import 'package:demo/widgets/coterieCard/index.dart';
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
  List<CoterieCardWidget> articleList = [];
  List<TagItem> tagList = [];
  int page = 1;
  int _selectedTagIndex = 0;
  String categoryId = '';

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _getArticleList();
    _getTagList();
  }

  Future<bool> _getArticleList() async {
    var articleListResponse = await getArticleList(
      AppStrings.microPost,
      page,
      categoryId: categoryId,
    );
    if (!mounted) return false;

    if (articleListResponse != null && articleListResponse.isNotEmpty) {
      setState(() {
        articleList.addAll(
          List.generate(
            articleListResponse.length,
            (index) => CoterieCardWidget(data: articleListResponse[index]),
          ),
        );
      });
      return true; // 表示还有数据
    } else {
      return false; // 表示没有更多数据
    }
  }

  Future _getTagList() async {
    var tagListResponse = await getTagList(AppStrings.microPost);
    if (!mounted) return;

    if (tagListResponse!.isNotEmpty) {
      setState(() {
        tagList = tagListResponse;
        tagList.insert(
          0,
          TagItem(
            id: '',
            name: "全部",
            description: '',
            icon: '',
            type: Type.ARTICLE,
            isSystemProvider: true,
            usageCount: 0,
            createdAt: 0,
            updatedAt: 0,
          ),
        );
      });
    }
  }

  void _onRefresh() async {
    if (mounted) {
      setState(() {
        articleList.clear();
        page = 1;
        _getArticleList();
      });
      _refreshController.refreshCompleted(); // 结束刷新状态
    }
  }

  void _onLoading() async {
    if (mounted) {
      page++;
      bool hasMore = await _getArticleList();
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
      backgroundColor: Colors.grey[100],
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
              buildTabBarContainer(),
              ...buildArticleList(),
            ],
          ),
        ),
      ),
    );
  }

  Iterable<Widget> buildArticleList() {
    return articleList.map(
      (article) => SizedBox(width: double.infinity, child: article),
    );
  }

  Container buildTabBarContainer() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tagList.length, (index) {
            final tag = tagList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTagIndex = index;
                  page = 1;
                  categoryId = tag.id;
                  articleList = [];
                  _getArticleList();
                  // 将 scroll 移动到最前面，移动的距离需要根据文字长度自动计算
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  tag.name,
                  style: TextStyle(
                    color:
                        _selectedTagIndex == index ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
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
