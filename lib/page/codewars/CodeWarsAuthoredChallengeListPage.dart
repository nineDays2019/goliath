import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeWarsAuthoredChallengeListPage extends StatelessWidget {
  String name;
  String id;

  CodeWarsAuthoredChallengeListPage({Key key, this.id, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Text("HelloWorld"),
    );
  }
}

// todo 列表页面
