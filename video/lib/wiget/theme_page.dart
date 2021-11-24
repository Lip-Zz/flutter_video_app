import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video/provider/theme_provider.dart';
import 'package:video/util/color.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  static const _items = [
    {
      'name': '跟随系统',
      'mode': ThemeMode.system,
    },
    {
      'name': '开启',
      'mode': ThemeMode.dark,
    },
    {
      'name': '关闭',
      'mode': ThemeMode.light,
    }
  ];

  late ThemeMode _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = context.read<ThemeProvider>().getThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return _item(index);
        },
        separatorBuilder: (c, i) => Divider(),
        itemCount: _items.length,
      ),
    );
  }

  Widget _item(int index) {
    var item = _items[index];
    return GestureDetector(
      onTap: () {
        _changeTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(child: Text((item["name"] as String))),
            Opacity(
              opacity: _currentTheme == item['mode'] ? 1 : 0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changeTheme(int index) {
    var item = _items[index];
    context.read<ThemeProvider>().setThemeMode(item['mode'] as ThemeMode);
    setState(() {
      _currentTheme = item['mode'] as ThemeMode;
    });
  }
}
