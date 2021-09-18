import 'package:flutter/material.dart';
import 'package:video/model/video.dart';
import 'package:video/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre) => {
          if (widget == current.page || current.page is HomePage)
            {printLog("打开了首页:onResume")}
          else if (widget == pre?.page || pre?.page is HomePage)
            {printLog("首页:onPause")}
          else
            {printLog("嘻嘻嘻")}
        });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            ElevatedButton(
                onPressed: () {
                  HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                      args: {'video': Video(3543)});
                },
                child: Text("跳转"))
          ],
        ),
      ),
    );
  }
}
