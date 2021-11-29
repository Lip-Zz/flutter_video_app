import 'package:flutter/material.dart';
import 'package:hi_barrage/barrage/barrageModel.dart';

class HiBarrageUtil {
  static Widget barrageItemView(BarrageModel mo) {
    switch (mo.type) {
      case 0:
        return _type1(mo);
      case 1:
        return _type2(mo);
      default:
        return _type1(mo);
    }
  }

  static Widget _type1(BarrageModel mo) {
    return Text(
      mo.content,
      style: TextStyle(color: Colors.white),
    );
  }

  static Widget _type2(BarrageModel mo) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black45,
            border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(3)),
        child: Text(
          mo.content,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
