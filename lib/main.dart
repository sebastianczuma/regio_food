import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regio_food/strings.dart';
import 'package:regio_food/ui/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: mainTitle,
        theme: ThemeData(
          primaryColorBrightness: Brightness.light,
        ),
        home: Home());
  }
}
