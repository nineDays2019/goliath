import 'package:flutter/material.dart';
import 'package:goliath/model/User.dart';
import 'package:goliath/other/debug.dart';
import 'package:goliath/page/HomePage.dart';
import 'package:goliath/service/AccountService.dart';

void main() => runApp(MyApp());

const TITLE = "今天做点什么";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debug();
    init();
    return MaterialApp(
      title: TITLE,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Color(0xffff4081),
          primaryColor: Color(0xff2196f3),
          primaryColorDark: Color(0xff1976d2),
          primaryColorLight: Color(0xffbbdefb),

      ),
      home: HomePage(title: TITLE),
    );
  }
}

init() {
  initAccount();
}

initAccount() {
  var service = AccountService.getInstance();
  var user = User("李一条");
  service.signIn(user);
}
