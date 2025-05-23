import 'package:demo/constant/app_route_path.dart';
import 'package:demo/request/models/articles.dart';
import 'package:demo/theme/index.dart';
import 'package:demo/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:markdown_widget/widget/markdown_block.dart';

class CoterieCardWidget extends StatelessWidget {
  final ArticleItem? data;

  const CoterieCardWidget({super.key, this.data});

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
        decoration: BoxDecoration(color: Colors.white),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data?.author.nickname ?? ""),
                    Text(
                      formatTimestamp(data!.article.updatedAt),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
              ],
            ),
            MarkdownBlock(data: data?.article.content ?? ""),
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
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
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
            Divider(height: 0.3, color: Colors.black.withAlpha(10)),
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
