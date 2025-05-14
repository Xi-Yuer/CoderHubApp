import 'package:demo/constant/app_string.dart';
import 'package:demo/widgets/banner/index.dart';
import 'package:demo/widgets/card/index.dart';
import 'package:demo/request/api/index.dart';
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
            idleText: AppStrings.pullToRefresh,
            refreshingText: AppStrings.refreshing,
            completeText: AppStrings.refreshComplete,
            failedText: AppStrings.refreshFailed,
            releaseText: AppStrings.releaseToRefresh,
          ),
          footer: CustomFooter(
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
          ),
          onRefresh: _onRefresh,
          enablePullUp: true,
          controller: _refreshController,
          onLoading: _onLoading,
          child: ListView.builder(
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
    );
  }
}
