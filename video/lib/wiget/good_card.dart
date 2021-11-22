import 'package:flutter/material.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/util/hi_blur.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/hi_banner.dart';

class GoodCard extends StatelessWidget {
  final List<BannerModel> courseList;
  const GoodCard({Key? key, this.courseList: const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [_head(), hiSpace(height: 10), _list(context)],
      ),
    );
  }

  _head() {
    return Container(
      child: Row(
        children: [
          Text(
            '周边推荐',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "好玩周边推荐给您",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  _list(BuildContext context) {
    var width =
        (MediaQuery.of(context).size.width - 20 - (courseList.length - 1) * 5) /
            courseList.length;
    return Row(
      children: [...courseList.map((e) => _card(e, width)).toList()],
    );
  }

  _card(BannerModel e, double width) {
    return GestureDetector(
      onTap: () {
        handleItemClick(e);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            child: Stack(
              children: [
                cacheNetworkImage(e.cover, width: width, height: 60),
                HiBlur(
                  sigma: 2,
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      e.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
