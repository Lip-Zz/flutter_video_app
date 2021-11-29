import 'package:flutter/material.dart';
import 'package:hi_base/util/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton(this.title, {Key? key, this.enable = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        child: MaterialButton(
            onPressed: this.enable ? this.onPressed : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            height: 45,
            disabledColor: primary[50],
            color: primary,
            child: Text(
              this.title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            )));
  }
}