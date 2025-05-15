import 'package:demo/request/index.dart';
import 'package:demo/request/models/articles.dart';
import 'package:demo/request/models/banner.dart';
import 'package:demo/request/models/tag.dart';

// 获取轮播图
Future<List<BannerItem>?> getBanner() async {
  var response = await request.get('/api/banner/list');
  var result = parseResponse<BannerResponse>(
    response.data,
    BannerResponse.fromJson,
  );
  return result.data;
}

// 获取文章列表
Future<List<ArticleItem>?> getArticleList(String type, num page) async {
  try {
    var response = await request.get(
      '/api/articles/list?type=$type&page=$page&page_size=10',
    );
    var result = parseResponse(response.data, ArticlesResponse.fromJson);
    final list = result.data.list;
    return list.isNotEmpty ? list : [];
  } catch (e) {
    return [];
  }
}

// 获取文章分类标签列表
Future<List<TagItem>?> getTagList(String type) async {
  try {
    var response = await request.get('/api/tag/system/list?type=$type');
    var result = parseResponse<Tag>(response.data, Tag.fromJson);
    final list = result.data.list;
    return list.isNotEmpty ? list : [];
  } catch (e) {
    return [];
  }
}
