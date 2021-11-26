import 'package:flutter/material.dart';
import 'package:hi_barrage/barrage/hi_barrage_transition.dart';

class HiBarrageItem extends StatelessWidget {
  final String vid;
  final double top;
  final Widget child;
  final ValueChanged<String>? onComplete;
  final Duration duration;
  HiBarrageItem(
    this.child,
    this.vid,
    this.duration, {
    Key? key,
    this.top: 0,
    this.onComplete,
  }) : super(key: key);
  var _key = GlobalKey<HiBarrageTransitionState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: HiBarrageTransition(
        child,
        duration,
        (value) {
          if (onComplete != null) {
            onComplete!(vid);
          }
        },
        key: _key,
      ),
    );
  }
}
