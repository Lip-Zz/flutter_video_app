import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  final bool protect;

  LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            image: AssetImage("images/logo.png"),
            width: 90,
            height: 90,
          ),
          _image(false)
        ],
      ),
    );
  }

  _image(bool left) {
    var leftIcon = widget.protect
        ? "images/head_left_protect.png"
        : "images/head_left.png";
    var rightIcon = widget.protect
        ? "images/head_right_protect.png"
        : "images/head_right.png";
    return Image(
      image: AssetImage(left ? leftIcon : rightIcon),
      height: 90,
    );
  }
}
