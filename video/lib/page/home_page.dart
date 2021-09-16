import 'package:flutter/material.dart';
import 'package:video/model/video.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<Video>? onJumpDetail;
  HomePage({Key? key, this.onJumpDetail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            TextButton(
                onPressed: () {
                  if (widget.onJumpDetail != null) {
                    widget.onJumpDetail!(Video(3));
                  }
                },
                child: Text("跳转"))
          ],
        ),
      ),
    );
  }
}
