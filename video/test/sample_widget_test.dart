import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video/page/sample_page.dart';

void main() {
  testWidgets('测试SamplePage页面', (WidgetTester tester) async {
    var app = MaterialApp(
      home: SamplePage(),
    );

    await tester.pumpWidget(app);

    expect(find.text('data'), findsOneWidget);
  });
}
