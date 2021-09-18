import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video/httpUtils/dao/login_dao.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/util/string_util.dart';
import 'package:video/util/toast.dart';
import 'package:video/wiget/appbar.dart';
import 'package:video/wiget/login_button.dart';
import 'package:video/wiget/login_effect.dart';
import 'package:video/wiget/login_input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// 闭眼 睁眼
  bool protect = false;

  /// 注册按钮的启用和禁用
  bool loginEnable = false;

  String? username;
  String? pwd;
  String? repwd;
  String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar("注册", "登录", () {
          HiNavigator.getInstance().onJumpTo(RouteStatus.login);
        }),
        body: Container(
          child: ListView(
            children: [
              LoginEffect(protect: protect),
              LoginInput(
                "用户名",
                "请输入用户名",
                onChanged: (text) {
                  this.username = text;
                  _checkInput();
                },
              ),
              LoginInput(
                "密码",
                "请输入密码",
                lineStretch: true,
                obscureText: true,
                onChanged: (text) {
                  this.pwd = text;
                  _checkInput();
                },
                focusChanged: (focus) {
                  this.setState(() {
                    this.protect = focus;
                  });
                },
              ),
              LoginInput(
                "确认密码",
                "请输入确认密码",
                lineStretch: true,
                obscureText: true,
                onChanged: (text) {
                  this.repwd = text;
                  _checkInput();
                },
                focusChanged: (focus) {
                  this.setState(() {
                    this.protect = focus;
                  });
                },
              ),
              LoginInput(
                "ID",
                "请输入ID",
                keybordType: TextInputType.number,
                onChanged: (text) {
                  this.id = text;
                  _checkInput();
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: _loginButton(),
              ),
            ],
          ),
        ));
  }

  void _checkInput() {
    bool enable;
    if (isNotEmpty(this.username) &&
        isNotEmpty(this.pwd) &&
        isNotEmpty(this.repwd) &&
        isNotEmpty(this.id)) {
      enable = true;
    } else {
      enable = false;
    }

    this.setState(() {
      this.loginEnable = enable;
    });
  }

  _loginButton() {
    return LoginButton(
      "注册",
      enable: this.loginEnable,
      onPressed: () {
        if (this.loginEnable) {
          _checkParams();
        } else {
          showWarnToast("参数错误");
        }
      },
    );
  }

  void _send() async {
    try {
      var result = await LoginDao.register(this.username!, this.pwd!, this.id!);
      if (result['code'] == 0) {
        showToast("注册成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      } else {
        showWarnToast(result['msg']);
      }
    } catch (e) {
      print(e);
    }
  }

  void _checkParams() {
    if (this.pwd == this.repwd) {
      _send();
    } else {
      showWarnToast("两次输入的密码不一致");
      return;
    }
  }
}
