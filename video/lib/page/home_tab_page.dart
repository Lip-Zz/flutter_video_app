import 'package:flutter/material.dart';
import 'package:video/core/hi_state.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/wiget/hi_banner.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  List<BannerModel>? bannerList;
  HomeTabPage({Key? key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          if (widget.bannerList != null) _banner(),
          Text("${widget.name},${widget.bannerList}")
        ],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(
        bannerList: widget.bannerList ?? [],
        bannerHeight: 200,
      ),
    );
  }
}
