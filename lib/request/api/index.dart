import 'package:demo/request/index.dart';
import 'package:demo/request/models/articles.dart';
import 'package:demo/request/models/banner.dart';

Future<List<BannerItem>?> getBanner() async {
  var response = await request.get('/api/banner/list');
  var result = parseResponse<BannerResponse>(
    response.data,
    BannerResponse.fromJson,
  );
  return result.data;
}

Future<List<ArticleItem>?> getArticleList(num page) async {
  var response = await request.get(
    '/api/articles/list?type=article&page=$page&page_size=10',
  );
  try {
    var result = parseResponse(response.data, ArticlesResponse.fromJson);
    final list = result.data.list;
    return list.isNotEmpty ? list : [];
  } catch (e) {
    return [];
  }
}
