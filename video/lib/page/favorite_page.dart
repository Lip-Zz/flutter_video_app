import 'package:flutter/material.dart';

class FavoriatePage extends StatefulWidget {
  FavoriatePage({Key? key}) : super(key: key);

  @override
  _FavoriatePageState createState() => _FavoriatePageState();
}

class _FavoriatePageState extends State<FavoriatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("收藏"),
      ),
    );
  }
}
