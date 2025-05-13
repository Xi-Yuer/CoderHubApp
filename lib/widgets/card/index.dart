import 'package:demo/constant/app_route_path.dart';
import 'package:demo/request/models/articles.dart';
import 'package:demo/utils/index.dart';
import 'package:flutter/material.dart';

class CardCom extends StatelessWidget {
  final ArticleItem? data;

  const CardCom({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // InkWell 自带涟漪效果
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutePath.webView,
          arguments: {'articleItem': data},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                ClipOval(
                  child: Image.network(
                    data?.author.avatar ?? "",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(data?.author.nickname ?? ""),
                Expanded(child: SizedBox()),
                Text(
                  formatTimestamp(data!.article.updatedAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Text(
              data?.article.title ?? "",
              maxLines: 2,
              // 多行文本溢出
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              data?.article.content ?? "",
              maxLines: 3,
              // 多行文本溢出
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 13,
              children: [
                Expanded(
                  // 保证滚动区域不会撑出父组件边界
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          (data?.article.tags ?? []).map((tag) {
                            return Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    _buildIconTextRow(
                      (data?.article.isFavorited ?? false)
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      "${data?.article.likeCount ?? 0}",
                    ),
                    _buildIconTextRow(
                      Icons.comment,
                      "${data?.article.commentCount ?? 0}",
                    ),
                    _buildIconTextRow(
                      Icons.remove_red_eye,
                      "${data?.article.viewCount ?? 0}",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildIconTextRow(IconData icon, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    spacing: 5,
    children: [
      Icon(icon, color: Colors.grey, size: 15),
      Text(text, style: TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  );
}
