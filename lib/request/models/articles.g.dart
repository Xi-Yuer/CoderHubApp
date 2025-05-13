// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesResponse _$ArticlesResponseFromJson(Map<String, dynamic> json) =>
    ArticlesResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: ArticlesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticlesResponseToJson(ArticlesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ArticlesData _$ArticlesDataFromJson(Map<String, dynamic> json) => ArticlesData(
  list:
      (json['list'] as List<dynamic>)
          .map((e) => ArticleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ArticlesDataToJson(ArticlesData instance) =>
    <String, dynamic>{'list': instance.list};

ArticleItem _$ArticleItemFromJson(Map<String, dynamic> json) => ArticleItem(
  article: Article.fromJson(json['article'] as Map<String, dynamic>),
  author: Author.fromJson(json['author'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticleItemToJson(ArticleItem instance) =>
    <String, dynamic>{'article': instance.article, 'author': instance.author};

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  id: json['id'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  summary: json['summary'] as String,
  imageUrls:
      (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
  coverImage: json['coverImage'] as String?,
  authorId: json['authorId'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  categoryId: json['categoryId'] as String,
  viewCount: (json['viewCount'] as num).toInt(),
  likeCount: (json['likeCount'] as num).toInt(),
  isLiked: json['isLiked'] as bool,
  isFavorited: json['isFavorited'] as bool,
  commentCount: (json['commentCount'] as num).toInt(),
  status: json['status'] as String,
  createdAt: (json['createdAt'] as num).toInt(),
  updatedAt: (json['updatedAt'] as num).toInt(),
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'content': instance.content,
  'summary': instance.summary,
  'imageUrls': instance.imageUrls,
  'coverImage': instance.coverImage,
  'authorId': instance.authorId,
  'tags': instance.tags,
  'categoryId': instance.categoryId,
  'viewCount': instance.viewCount,
  'likeCount': instance.likeCount,
  'isLiked': instance.isLiked,
  'isFavorited': instance.isFavorited,
  'commentCount': instance.commentCount,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
  id: json['id'] as String,
  username: json['username'] as String,
  nickname: json['nickname'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  avatar: json['avatar'] as String,
  level: (json['level'] as num).toInt(),
  gender: (json['gender'] as num).toInt(),
  age: (json['age'] as num).toInt(),
  status: json['status'] as bool,
  isAdmin: json['is_admin'] as bool,
  createAt: (json['create_at'] as num).toInt(),
  updateAt: (json['update_at'] as num).toInt(),
  followCount: (json['follow_count'] as num).toInt(),
  fansCount: (json['fans_count'] as num).toInt(),
  isFollowed: json['is_followed'] as bool,
  articleCount: (json['article_count'] as num).toInt(),
);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'nickname': instance.nickname,
  'email': instance.email,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'level': instance.level,
  'gender': instance.gender,
  'age': instance.age,
  'status': instance.status,
  'is_admin': instance.isAdmin,
  'create_at': instance.createAt,
  'update_at': instance.updateAt,
  'follow_count': instance.followCount,
  'fans_count': instance.fansCount,
  'is_followed': instance.isFollowed,
  'article_count': instance.articleCount,
};
