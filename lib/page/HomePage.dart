import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
//                background: Image.network(
//                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
//                  fit: BoxFit.cover,
//                ),
              ),
              actions: <Widget>[
                new IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: null,
                  tooltip: "更多",
                )
              ],
            )
          ];
        },
        body: Center(
          child: Text("Content"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: "做点什么",
        child: Icon(Icons.add),
      ),
    );
  }
}
