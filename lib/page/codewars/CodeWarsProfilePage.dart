/*CodeWars Profile 页*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goliath/model/codewars/CodeWarsUser.dart';
import 'package:goliath/other/color.dart';
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
                title: Text(
                  user.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.asset(
                  "images/codewars_content.png",
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
        body: MessageCard(
          user: user,
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
  final CodeWarsUser user;

  MessageCard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: new EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      user.name,
                      style: new TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: new Text('Name'),
                    leading: new Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  new Divider(),
                  new ListTile(
                    title: new Text(
                      "${user.honor}",
                      style: new TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: new Text('Rank'),
                    leading: new Icon(Icons.contact_phone,
                        color: Theme.of(context).primaryColor),
                  ),
                  new ListTile(
                    title: new Text(
                      user.clan,
                      style: new TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: new Text('Clan'),
                    leading: new Icon(Icons.home,
                        color: Theme.of(context).primaryColor),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 10.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('总览'),
                    leading: Icon(
                      Icons.assessment,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("${user.codeChallenges.totalAuthored}"),
                    subtitle: Text('发布'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    title: Text("${user.codeChallenges.totalCompleted}"),
                    subtitle: Text('完成'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )
                ],
              ),
            ),
            Card(
              elevation: 10.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              color: Colors.black38,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Rank 总览',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.assessment,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      user.ranks.overall.name,
                      style:
                          TextStyle(color: makeColor(user.ranks.overall.color)),
                    ),
                    subtitle: Text(
                      'Name',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "${user.ranks.overall.score}",
                      style:
                          TextStyle(color: makeColor(user.ranks.overall.color)),
                    ),
                    subtitle: Text(
                      'Score',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class RanksCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
