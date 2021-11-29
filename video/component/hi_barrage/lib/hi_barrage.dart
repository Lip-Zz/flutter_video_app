library hi_barrage;

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hi_barrage/barrage/barrageModel.dart';
import 'package:hi_barrage/barrage/hi_barrage_item.dart';
import 'package:hi_barrage/barrage/hi_barrage_util.dart';
import 'package:hi_barrage/barrage/hi_socket.dart';
import 'package:hi_barrage/barrage/iBarrage.dart';

class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;
  final Map<String, dynamic> headers;
  HiBarrage(
    this.vid,
    this.headers, {
    Key? key,
    this.lineCount: 4,
    this.speed: 800,
    this.top: 0,
    this.autoPlay: false,
  }) : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  late HiSocket _hiSocket;
  double _height = 0;
  double _width = 0;
  List<HiBarrageItem> _barrageItemList = [];
  List<BarrageModel> _barrageMoList = [];
  int _barrageIndex = 0;
  Random _random = Random();
  BarrageStatus? _barrageStatus;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket(widget.headers);
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    _hiSocket.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [Container()]..addAll(_barrageItemList),
      ),
    );
  }

  ///添加弹幕
  void _addBarrage(BarrageModel temp) {
    double rowHeight = 30;
    //第几行
    var row = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = row * rowHeight + widget.top;
    String id = '${_random.nextInt(999999)}:${temp.content}';
    var item = HiBarrageItem(
      HiBarrageUtil.barrageItemView(temp),
      id,
      Duration(seconds: 9),
      top: top,
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  void _handleMessage(List<BarrageModel> value, {bool sendRightNow: false}) {
    if (sendRightNow) {
      _barrageMoList.insertAll(0, value);
    } else {
      _barrageMoList.addAll(value);
    }

    //收到新弹幕，当前正在播放，立即播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }

    //当前不是暂停状态并且是自动播放，就开始播放
    if (_barrageStatus != BarrageStatus.pause && widget.autoPlay) {
      play();
    }
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    //清除弹幕
    _barrageItemList.clear();
    setState(() {});
    _timer?.cancel();
    print("HiBarrage:pause:清除弹幕");
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    print("HiBarrage:开始播放弹幕");
    if (_timer != null && _timer?.isActive == true) {
      return;
    }

    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageMoList.isNotEmpty) {
        //每取出一条就删除一条
        var temp = _barrageMoList.removeAt(0);
        _addBarrage(temp);
        print("HiBarrage:add:添加弹幕");
      } else {
        //没有弹幕就把定时器关掉
        _timer?.cancel();
        print("HiBarrage:关闭定时器");
      }
    });
  }

  @override
  void send(String message) {
    if (message.isNotEmpty) {
      _hiSocket.send(message);
      _handleMessage([
        BarrageModel(content: message, vid: widget.vid, priority: 1, type: 1)
      ]);
    }
  }

  /// 弹幕播放完成
  void _onComplete(value) {
    print("HiBarrage:播放完毕删除,id:{$value}");
    _barrageItemList.removeWhere((element) => element.vid == value);
  }
}
