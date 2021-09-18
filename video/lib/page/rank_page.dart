import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("排行"),
      ),
    );
  }
}
