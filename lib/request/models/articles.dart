import 'package:json_annotation/json_annotation.dart';

part 'articles.g.dart';

@JsonSerializable()
class ArticlesResponse {
  final int code;
  final String message;
  final ArticlesData data;

  ArticlesResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesResponseToJson(this);
}

@JsonSerializable()
class ArticlesData {
  final List<ArticleItem> list;

  ArticlesData({required this.list});

  factory ArticlesData.fromJson(Map<String, dynamic> json) =>
      _$ArticlesDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesDataToJson(this);
}

@JsonSerializable()
class ArticleItem {
  final Article article;
  final Author author;

  ArticleItem({required this.article, required this.author});

  factory ArticleItem.fromJson(Map<String, dynamic> json) =>
      _$ArticleItemFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleItemToJson(this);
}

@JsonSerializable()
class Article {
  final String id;
  final String type;
  final String title;
  final String content;
  final String summary;
  final List<String> imageUrls;
  final String? coverImage;
  final String authorId;
  final List<String>? tags;
  final String categoryId;
  final int viewCount;
  final int likeCount;
  final bool isLiked;
  final bool isFavorited;
  final int commentCount;
  final String status;
  final int createdAt;
  final int updatedAt;

  Article({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.summary,
    required this.imageUrls,
    this.coverImage,
    required this.authorId,
    this.tags,
    required this.categoryId,
    required this.viewCount,
    required this.likeCount,
    required this.isLiked,
    required this.isFavorited,
    required this.commentCount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Author {
  final String id;
  final String username;
  final String nickname;
  final String email;
  final String phone;
  final String avatar;
  final int level;
  final int gender;
  final int age;
  final bool status;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  @JsonKey(name: 'create_at')
  final int createAt;
  @JsonKey(name: 'update_at')
  final int updateAt;
  @JsonKey(name: 'follow_count')
  final int followCount;
  @JsonKey(name: 'fans_count')
  final int fansCount;
  @JsonKey(name: 'is_followed')
  final bool isFollowed;
  @JsonKey(name: 'article_count')
  final int articleCount;

  Author({
    required this.id,
    required this.username,
    required this.nickname,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.level,
    required this.gender,
    required this.age,
    required this.status,
    required this.isAdmin,
    required this.createAt,
    required this.updateAt,
    required this.followCount,
    required this.fansCount,
    required this.isFollowed,
    required this.articleCount,
  });

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}