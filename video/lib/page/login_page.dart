import 'package:flutter/material.dart';
import 'package:video/httpUtils/dao/login_dao.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/util/string_util.dart';
import 'package:video/util/toast.dart';
import 'package:video/wiget/appbar.dart';
import 'package:video/wiget/login_button.dart';
import 'package:video/wiget/login_effect.dart';
import 'package:video/wiget/login_input.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onJumpToRegister;
  final VoidCallback? onLoginSuccess;
  LoginPage({Key? key, this.onJumpToRegister, this.onLoginSuccess})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 闭眼 睁眼
  bool protect = false;

  /// 注册按钮的启用和禁用
  bool loginEnable = false;

  String? username;
  String? pwd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("密码登录", "注册", () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.register);
      }, key: Key('register')),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: this.protect),
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
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  void _checkInput() {
    bool enable;
    if (isNotEmpty(this.username) && isNotEmpty(this.pwd)) {
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
      "登录",
      enable: this.loginEnable,
      onPressed: () {
        if (this.loginEnable) {
          _send();
        } else {
          showWarnToast("参数错误");
        }
      },
    );
  }

  void _send() async {
    try {
      var result = await LoginDao.login(this.username!, this.pwd!);
      if (result['code'] == 0) {
        showToast("登录成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        showWarnToast(result['msg']);
      }
    } catch (e) {
      showWarnToast(e.toString());
    }
  }
}
