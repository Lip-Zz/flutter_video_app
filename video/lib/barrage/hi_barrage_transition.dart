import 'package:flutter/material.dart';

class HiBarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onComplete;
  HiBarrageTransition(
    this.child,
    this.duration,
    this.onComplete, {
    Key? key,
  }) : super(key: key);

  @override
  HiBarrageTransitionState createState() => HiBarrageTransitionState();
}

class HiBarrageTransitionState extends State<HiBarrageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        widget.onComplete('');
      }
    });

    var begin = Offset(1.0, 0);
    var end = Offset(-1.0, 0);
    _animation = Tween(
      begin: begin,
      end: end,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
