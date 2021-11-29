import 'package:flutter/material.dart';
import 'package:hi_base/util/view_util.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:hi_base/util/format_util.dart';

class VideoLargeCard extends StatelessWidget {
  final VideoModel? mo;
  const VideoLargeCard({Key? key, this.mo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {'video': mo});
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: EdgeInsets.only(bottom: 6),
        height: 106,
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            _image(context),
            _info(context),
          ],
        ),
      ),
    );
  }

  _image(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cacheNetworkImage(mo?.cover ?? "",
              width: height * 16 / 9, height: height),
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              padding: EdgeInsets.all(2),
              color: Colors.black38,
              child: Text(
                durationTransform(mo?.seconds ?? 0),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          )
        ],
      ),
    );
  }

  _info(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 8, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mo?.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            _infoDetail(),
          ],
        ),
      ),
    );
  }

  _infoDetail() {
    return Column(
      children: [
        _owner(),
        hiSpace(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.video_call, mo?.view ?? 0),
                hiSpace(width: 5),
                ...smallIconText(Icons.comment, mo?.reply ?? 0),
              ],
            ),
            Icon(
              Icons.more_vert_sharp,
              size: 11,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  _owner() {
    return Row(
      children: [...smallIconText(Icons.person, mo?.owner?.name ?? '')],
    );
  }
}
