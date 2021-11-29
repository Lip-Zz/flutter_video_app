import 'package:flutter/material.dart';
import 'package:hi_base/util/view_util.dart';
import 'package:video/model/ownerModel.dart';
import 'package:hi_base/util/color.dart';
import 'package:hi_base/util/format_util.dart';

class VideoHeader extends StatelessWidget {
  final OwnerModel? owner;
  const VideoHeader({Key? key, this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                child:
                    cacheNetworkImage(owner?.face ?? "", width: 30, height: 30),
                borderRadius: BorderRadius.circular(15),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Text(
                      owner?.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: primary,
                      ),
                    ),
                    Text(
                      countFormat(owner?.fans ?? 0),
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {},
            color: primary,
            height: 24,
            minWidth: 50,
            child: Text(
              '关注',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
