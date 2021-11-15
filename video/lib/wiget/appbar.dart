import 'package:flutter/material.dart';
import 'package:video/util/view_util.dart';

appbar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

videoAppbar({VoidCallback? onBack}) {
  return Container(
    padding: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
          onPressed: () {
            print(11111);
          },
        ),
        Row(
          children: [
            Icon(
              Icons.tv,
              color: Colors.white,
              size: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.more_horiz_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        )
      ],
    ),
  );
}
