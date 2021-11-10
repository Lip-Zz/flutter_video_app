import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/navigator/hi_navigator.dart';

class HiBanner extends StatelessWidget {
  final List<BannerModel> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;

  const HiBanner(
      {Key? key,
      this.bannerList: const [],
      this.bannerHeight: 0,
      this.padding: const EdgeInsets.only(left: 4, right: 4)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _banner(),
      height: this.bannerHeight,
    );
  }

  _banner() {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (context, index) {
        return _image(context, index);
      },
      pagination: SwiperPagination(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: 8),
        builder: DotSwiperPaginationBuilder(
            color: Colors.white60, size: 6, activeSize: 7),
      ),
    );
  }

  _image(BuildContext context, int index) {
    BannerModel mo = this.bannerList[index];
    return InkWell(
      onTap: () {
        _handleItemClick(mo);
      },
      child: Container(
        padding: this.padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Image.network(
            mo.cover,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleItemClick(BannerModel mo) {
    if (mo.type == 'video') {
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'video': VideoModel(url: mo.url)});
    } else {
      print("点击跳转到h5,${mo.url}");
    }
  }
}
