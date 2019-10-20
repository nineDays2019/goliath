/*CodeWars Profile 页*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goliath/model/codewars/CodeWarsUser.dart';
import 'package:goliath/page/common/CommonErrorPage.dart';
import 'package:goliath/page/common/CommonLoadingPage.dart';
import 'package:goliath/service/CodeWarsService.dart';
import 'package:goliath/widgets/CommonShadowContainer.dart';

class CodeWarsProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
        accentColor: Colors.yellow,
        primaryColor: Colors.blue,
      ),
      child: _ProfileContainer(),
    );
  }
}

class _ProfileContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<_ProfileContainer> {
  Future<CodeWarsUser> futureUser;

  @override
  void initState() {
    futureUser = CodeWarsService.requestUser("qiaoyunrui");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUser,
      builder: (BuildContext context, AsyncSnapshot<CodeWarsUser> user) {
        if (user.connectionState != ConnectionState.waiting) {
          if (user.data != null) {
            return new _ProfilePage(
              user: user.data,
            );
          } else {
            return CommonErrorPage(
              onPressed: () {
                setState(() {
                  futureUser = CodeWarsService.requestUser("qiaoyunrui");
                  print("Hello");
                });
              },
            );
          }
        } else {
          return CommonLoadingPage(
            onPressed: () => Navigator.of(context).pop(),
          );
        }
      },
    );
  }
}

class _ProfilePage extends StatelessWidget {
  final CodeWarsUser user;

  _ProfilePage({Key key, this.user}) : super(key: key);

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
              brightness: Brightness.dark,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: CommonShadowContainer(
                    child: Text(
                  user.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
                background: Image.asset(
                  "images/codewars_content.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: Text("More"),
                    ));
                    print(user.ranks.overall.name);
                  },
                  tooltip: "更多",
                ),
              ],
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: buildItem,
          itemCount: 1000,
        ),
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
}

class MessageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class RanksCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
