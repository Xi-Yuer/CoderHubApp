import 'package:demo/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

class BannerCom extends StatefulWidget {
  const BannerCom({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BannerComState();
  }
}

class _BannerComState extends State<BannerCom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    appProvider.getBannerAction();
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Swiper(
        itemBuilder: (context, index) {
          String imagePath = appProvider.bannerData?[index].imageUrl ?? "";
          return Container(
            height: 220,
            width: double.infinity,
            color: Colors.blue,
            child: Image.network(imagePath, fit: BoxFit.cover),
          );
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        pagination: SwiperPagination(),
        control: SwiperControl(),
        itemCount: appProvider.bannerData?.length ?? 0,
        autoplay: true,
      ),
    );
  }
}
