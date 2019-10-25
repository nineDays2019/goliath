import 'package:flutter/material.dart';

class CommonErrorPage extends StatelessWidget {
  final VoidCallback onPressed;

  CommonErrorPage({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text("加载失败",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                      decoration: TextDecoration.none))),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FlatButton(
                child: Text(
                  "重试",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: this.onPressed,
              ))
        ],
      ),
    );
  }
}
