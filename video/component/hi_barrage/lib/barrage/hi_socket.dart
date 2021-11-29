import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hi_barrage/barrage/barrageModel.dart';
import 'package:web_socket_channel/io.dart';

abstract class ISocket {
  ISocket open(String vid); //开启
  ISocket send(String message); //发送
  void close(); //关闭
  ISocket listen(ValueChanged<List<BarrageModel>> callBack); //接收
}

class HiSocket extends ISocket {
  //https://github.com/magicdam/MagicSocketDebugger
  //https://github.com/rangaofei/SSokit-qmake
  static const String _url = "ws://192.168.50.238:2025";
  IOWebSocketChannel? _channel;
  ValueChanged<List<BarrageModel>>? _callBack;

  final Map<String, dynamic> headers;

  HiSocket(this.headers);

  /// 心跳间隔
  int _intervaleSeconds = 50;

  @override
  void close() {
    _channel?.sink.close();
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(Uri.parse(_url),
        headers: headers, pingInterval: Duration(seconds: _intervaleSeconds));
    _channel?.stream.handleError((error) {
      print('HiSocket:error:${error.toString()}');
    }).listen((message) {
      print('HiSocket:message:$message');
      _handleMessage(message);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel?.sink.add(message);
    return this;
  }

  _handleMessage(message) {
    print('HiSocket:$message');
    if (jsonDecode(message) is List) {
      var list = jsonDecode(message) as List?;
      if (list != null && _callBack != null) {
        var moList = list.map((e) {
          return BarrageModel.fromJson(e);
        }).toList();
        _callBack!(moList);
      }
    } else {
      print('HiSocket:不是数组:$message');
    }
  }
}
