import 'package:flutter/material.dart';
import 'package:video/model/bannerModel.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  List<BannerModel>? bannerList;
  HomeTabPage({Key? key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${widget.name},${widget.bannerList}"),
    );
  }
}
