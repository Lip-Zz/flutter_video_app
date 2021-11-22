import 'package:flutter/material.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/hi_banner.dart';

class CourseCard extends StatelessWidget {
  final List<BannerModel> courseList;
  const CourseCard({Key? key, this.courseList: const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [_head(), hiSpace(height: 10), ..._list(context)],
      ),
    );
  }

  _head() {
    return Container(
      child: Row(
        children: [
          Text(
            '影视推荐',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "精彩视频推荐给您",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  _list(BuildContext context) {
    var group = Map();
    courseList.forEach((e) {
      if (!group.containsKey(e.type)) {
        group[e.type] = [];
      }
      List list = group[e.type];
      list.add(e);
    });

    return group.entries.map((e) {
      List list = e.value;
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
              list.length;
      var height = width / 16 * 6;
      return Row(
        children: [...list.map((e) => _card(e, width, height)).toList()],
      );
    });
  }

  _card(BannerModel e, double width, double height) {
    return GestureDetector(
      onTap: () {
        handleItemClick(e);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: cacheNetworkImage(e.cover, width: width, height: height),
        ),
      ),
    );
  }
}
