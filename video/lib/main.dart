import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video/db/hi_cache.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/core/hi_net.dart';
import 'package:video/httpUtils/dao/login_dao.dart';
import 'package:video/httpUtils/request/notice_request.dart';
import 'package:video/model/owner.dart';
import 'package:video/httpUtils/request/test_request.dart';
import 'package:video/page/register_page.dart';
import 'package:video/util/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: RegisterPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  }

  void _incrementCounter() async {
    // TestRequest request = TestRequest()
    //   ..addHeader("k", "v")
    //   ..add("1", "2");
    // try {
    //   var result = await HiNET.getInstance().fire(request);
    //   print(result);
    // } on NeedAuth catch (e) {
    //   print(e);
    // } on NeedLogin catch (e) {
    //   print(e);
    // } on HiNETError catch (e) {
    //   print(e);
    // }

    // testJson();
    // test1();
    //test2();
    //test3();
    // test4();
    test5();
  }

  void test5() async {
    try {
      var result = await HiNET.getInstance().fire(NoticeRequest());
      print(result);
    } catch (e) {
      print(e);
    }
  }

  void test4() async {
    try {
      var result = await LoginDao.login("1", "2");
      print(result);
    } catch (e) {
      print(e);
    }
  }

  void test3() async {
    try {
      var result = await LoginDao.register("1", "2", "3");
      print(result);
    } catch (e) {
      print(e);
    }
  }

  void test2() {
    HiCache.getInstance().setString("aa", "124124fsdf");
    print("hicache:${HiCache.getInstance().get<String>("aa")}");
  }

  void test1() {
    var ownerMap = {"name": "112312", "face": "2", "fans": 0};
    Owner o = Owner.fromJson(ownerMap);
    print("json:${o.name}");
  }

  void testJson() {
    var json = "{\"name\":\"flutter\"}";
    Map<String, dynamic> jsonMap = jsonDecode(json);
    print(jsonMap["name"]);
    print(jsonEncode(jsonMap));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
