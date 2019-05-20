import 'package:flutter/material.dart';
import 'package:goliath/page/HomePage.dart';

void main() => runApp(MyApp());

const TITLE = "今天做点什么";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: TITLE),
    );
  }
}
