import 'package:dispesas/pages/home_page.dart';
import 'package:dispesas/theme/theme_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dispesas',
      theme: ThemeApp.themeWhite(),
      home: HomePage(),
    );
  }
}
