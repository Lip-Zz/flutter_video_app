import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:video/main.dart' as app;
import 'package:video/navigator/hi_navigator.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('登录跳转注册', (tester) async {
    app.main();

    await tester.pumpAndSettle();

    var button = find.byKey(Key('register'));
    await tester.tap(button);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 3));

    /// 是否到注册页面
    expect(
        HiNavigator.getInstance().current?.routeStatus, RouteStatus.register);

    var backButton = find.byType(BackButton);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 3));

    /// 是否到登录页面
    expect(HiNavigator.getInstance().current?.routeStatus, RouteStatus.login);
  });
}
