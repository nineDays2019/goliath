import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeWarsSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CodeWars"),
      ),
      body: new Center(
        child: new CupertinoButton(
            child: new Text("快速开始"),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}

//搜索栏参考文章 https://www.jianshu.com/p/63aca25a463c
