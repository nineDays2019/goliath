import 'package:flutter/material.dart';

class CommonLoadingPage extends StatelessWidget {
  final VoidCallback onPressed;

  CommonLoadingPage({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("加载中...",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                    decoration: TextDecoration.none)),
          ),
//          先隐藏取消按钮
          /*Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FlatButton(
                child: Text(
                  "取消",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: this.onPressed,
              ))*/
        ],
      ),
    );
  }
}
