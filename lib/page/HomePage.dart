import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'DrawerPage.dart';
import 'codewars/CodeWarsProfilePage.dart';
import 'todo/SearchTodoPage.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[
                new IconButton(
                    tooltip: 'Search',
                    icon: new Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () => showSearchTodoPage(context)),
                new IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text("More"),
                  )),
                  tooltip: "更多",
                )
              ],
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: buildItem,
          itemCount: 1000,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new CodeWarsProfilePage())),
        tooltip: "做点什么",
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: DrawerPage(),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    if (index.isOdd) {
      return new Divider();
    }
    var textStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text("To do $index", style: textStyle),
    );
  }

  void showSearchTodoPage(BuildContext context) async {
    final String result =
        await showSearch(context: context, delegate: SearchTodoDelegate());
    if (result != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('搜索： $result'),
      ));
    }
  }
}