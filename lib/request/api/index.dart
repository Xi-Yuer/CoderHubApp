import 'package:demo/request/index.dart';
import 'package:demo/request/models/articles.dart';
import 'package:demo/request/models/banner.dart';
import 'package:demo/request/models/tag.dart';

// 获取轮播图
Future<List<BannerItem>?> getBanner() async {
  try {
    var response = await request.get('/api/banner/list');
    var result = parseResponse<BannerResponse>(
      response.data,
      BannerResponse.fromJson,
    );
    return result.data.isNotEmpty ? result.data : [];
  } catch (e) {
    return [];
  }
}

// 获取文章列表
Future<List<ArticleItem>?> getArticleList(
  String type,
  num page, {
  String? categoryId,
}) async {
  try {
    var response = await request.get(
      '/api/articles/list',
      queryParameters: {
        'type': type,
        'page': page,
        'category_id': categoryId,
        'page_size': 10,
      },
    );
    var result = parseResponse(response.data, ArticlesResponse.fromJson);
    return result.data.list.isNotEmpty ? result.data.list : [];
  } catch (e) {
    return [];
  }
}

// 获取文章分类标签列表
Future<List<TagItem>?> getTagList(String type) async {
  try {
    var response = await request.get(
      '/api/tag/system/list',
      queryParameters: {"type": type},
    );
    var result = parseResponse<Tag>(response.data, Tag.fromJson);
    return result.data.list.isNotEmpty ? result.data.list : [];
  } catch (e) {
    return [];
  }
}
