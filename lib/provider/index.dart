import 'package:demo/request/api/index.dart';
import 'package:demo/request/models/banner.dart';
import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  List<BannerItem>? bannerData = [];

  Future<void> getBannerAction() async {
    bannerData = await getBanner();
    notifyListeners();
  }

}
