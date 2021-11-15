import 'package:flutter/material.dart';
import 'package:video/model/ownerModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/util/format_util.dart';
import 'package:video/util/view_util.dart';

class VideoCard extends StatelessWidget {
  final VideoModel? videoModel;
  const VideoCard({Key? key, this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {'video': videoModel});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.only(left: 0, right: 0, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: [
                _itemImage(context),
                _infoText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // FadeInImage.memoryNetwork(
        //     height: 120,
        //     width: size.width / 2 - 20,
        //     fit: BoxFit.cover,
        //     placeholder: kTransparentImage,
        //     image: videoModel?.cover ?? ""),
        cacheNetworkImage(videoModel?.cover ?? "",
            width: size.width / 2 - 10, height: 120),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _iconText(Icons.people, countFormat(videoModel?.view ?? 0)),
                  Padding(padding: EdgeInsets.only(left: 3)),
                  _iconText(Icons.timelapse,
                      durationTransform(videoModel?.seconds ?? 0)),
                ],
              ),
            ))
      ],
    );
  }

  _iconText(IconData icon, String s) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 10,
        ),
        Padding(padding: EdgeInsets.only(left: 3)),
        Text(
          s,
          style: TextStyle(color: Colors.white, fontSize: 10),
        )
      ],
    );
  }

  _infoText() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              videoModel?.name ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            _owner(),
          ],
        ),
      ),
    );
  }

  _owner() {
    OwnerModel o = videoModel?.owner ?? OwnerModel();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: cacheNetworkImage(o.face, width: 24, height: 24),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                o.name,
                style: TextStyle(fontSize: 11, color: Colors.black),
              ),
            )
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          color: Colors.grey,
          size: 15,
        )
      ],
    );
  }
}
