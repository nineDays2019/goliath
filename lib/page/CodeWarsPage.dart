import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goliath/service/CodeWarsService.dart';
import 'package:goliath/service/DBService.dart';

class CodeWarsSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CodeWars"),
      ),
      body: CodeWarsProfileWrapper(),
    );
  }
}

/*new ListView(
        children: <Widget>[
          new CodeWarsProfileHeader(),
        ],
      )*/

class CodeWarsProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          new Image.network(
            "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          new Align(
            alignment: Alignment.centerLeft,
            child: new Padding(
              padding: new EdgeInsets.only(left: 12),
              child: new Column(
                children: <Widget>[
                  new Text(
                    "",
                    style: new TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CodeWarsProfileWrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CodeWarsProfileWrapperState();
  }
}

class _CodeWarsProfileWrapperState extends State<CodeWarsProfileWrapper> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        child: Text("绑定"),
        color: Colors.blueAccent,
        pressedOpacity: 0.8,
        onPressed: () {
          gotoSearch(context);
        },
      ),
    );
  }
}

gotoSearch(BuildContext context) async {
  String result = await showSearch<String>(
      context: context, delegate: CodeWarsSearchDelegate());
  print("key: $result");
  String json = await CodeWarsService.queryUser(result);
  print(json);
}

class CodeWarsSearchDelegate extends SearchDelegate<String> {
  static const DB_NAME = "CodeWarsHistory";

  var dbService = new DBService(DB_NAME);

  // 返回一个控件列表，显示为搜索框右面的图标
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
            showSuggestions(context);
          })
    ];
  }

  // 显示为搜索框左侧的按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.code,
        color: Colors.blue,
      ),
      title: Text(
        query,
        style: Theme.of(context).textTheme.title,
      ),
      onTap: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var list = new List<String>.generate(10, (index) => "HelloWorld $index");
    return ListView(
      children: <Widget>[
        // ignore: sdk_version_ui_as_code
        for (String item in list)
          ListTile(
            leading: Icon(Icons.message),
            title: Text(
              item,
              style: Theme.of(context).textTheme.title,
            ),
            onTap: () {
              close(context, item);
            },
          )
      ],
    );
  }
}
