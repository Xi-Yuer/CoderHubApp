
import 'package:intl/intl.dart';


// 时间戳格式化函数
String formatTimestamp(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  return formattedDate;
}
