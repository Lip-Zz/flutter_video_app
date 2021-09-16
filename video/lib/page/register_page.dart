import 'package:flutter/material.dart';
import 'package:video/wiget/appbar.dart';
import 'package:video/wiget/login_effect.dart';
import 'package:video/wiget/login_input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool protect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar("注册", "登录", () {
          print("right button click");
        }),
        body: Container(
          child: ListView(
            children: [
              LoginEffect(protect: protect),
              LoginInput(
                "用户名",
                "请输入用户名",
                onChanged: (text) {
                  print(text);
                },
              ),
              LoginInput(
                "密码",
                "请输入密码",
                lineStretch: true,
                obscureText: true,
                onChanged: (text) {
                  print(text);
                },
                focusChanged: (focus) {
                  this.setState(() {
                    this.protect = focus;
                  });
                },
              )
            ],
          ),
        ));
  }
}
