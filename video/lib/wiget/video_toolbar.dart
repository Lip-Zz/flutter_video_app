import 'package:flutter/material.dart';
import 'package:hi_base/util/view_util.dart';
import 'package:video/model/videoDetailModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:hi_base/util/color.dart';
import 'package:hi_base/util/format_util.dart';

class VideoToolBar extends StatelessWidget {
  final VideoModel? mo;
  final VideoDetailModel? detailMo;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  const VideoToolBar(
      {Key? key,
      this.mo,
      this.detailMo,
      this.onLike,
      this.onUnLike,
      this.onCoin,
      this.onFavorite,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //点赞
          _buildIconText(Icons.thumb_up_alt_rounded, mo?.view ?? 0,
              onclick: onLike, tint: detailMo?.isLike ?? false),
          //倒赞
          _buildIconText(Icons.thumb_down_alt_rounded, 0,
              onclick: onUnLike, tint: false),
          //投币
          _buildIconText(Icons.monetization_on, 0,
              onclick: onCoin, tint: false),
          //收藏
          _buildIconText(Icons.grade_rounded, mo?.reply ?? 0,
              onclick: onFavorite, tint: detailMo?.isFavorite ?? false),
          //分享
          _buildIconText(Icons.share_rounded, 0, onclick: onShare, tint: false),
        ],
      ),
    );
  }

  _buildIconText(IconData icon, dynamic s, {onclick, bool tint: false}) {
    if (s is int) {
      s = countFormat(s);
    }
    return InkWell(
      onTap: onclick,
      child: Column(
        children: [
          Icon(
            icon,
            color: tint ? primary : Colors.grey,
            size: 20,
          ),
          hiSpace(height: 5),
          Text(
            s,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
