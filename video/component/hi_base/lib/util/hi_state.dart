import 'package:flutter/material.dart';

abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
      print('HiState:${this.widget}页面setstate');
    } else {
      print('HiState:${this.widget}页面已销毁，本次setstate不执行,${toString()}');
    }
  }
}
