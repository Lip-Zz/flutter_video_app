import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:video/provider/theme_provider.dart';

List<SingleChildWidget> topProvider = [
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
];
