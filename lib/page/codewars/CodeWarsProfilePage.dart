/*CodeWars Profile 页*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goliath/model/codewars/CodeWarsUser.dart';
import 'package:goliath/other/color.dart';
import 'package:goliath/page/common/CommonErrorPage.dart';
import 'package:goliath/page/common/CommonLoadingPage.dart';
import 'package:goliath/service/CodeWarsService.dart';
import 'package:goliath/widgets/CommonShadowContainer.dart';
import 'package:goliath/widgets/WidgetBuilder.dart';

class CodeWarsProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
        accentColor: Colors.yellow,
        primaryColor: Color.fromARGB(255, 69, 109, 243),
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
          body: ListView(
            children: <Widget>[
              MessageCard(
                user: user,
              ),
              RanksCard(
                user: user,
              )
            ],
          )),
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
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                elevation: 10.0,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Rank 总览',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(
                          Icons.assessment,
                          color: makeCodeWarsColor(user.ranks.overall.color),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          user.ranks.overall.name,
                          style: TextStyle(
                              color:
                                  makeCodeWarsColor(user.ranks.overall.color)),
                        ),
                        subtitle: Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "${user.ranks.overall.score}",
                          style: TextStyle(
                              color:
                                  makeCodeWarsColor(user.ranks.overall.color)),
                        ),
                        subtitle: Text(
                          'Score',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  decoration: buildGradient([
                    Color.fromARGB(255, 69, 109, 243),
                    Color.fromARGB(255, 93, 172, 248)
                  ]),
                ),
              ),
            )
          ],
        ));
  }
}

class RanksCard extends StatelessWidget {
  final CodeWarsUser user;

  RanksCard({Key key, this.user}) : super(key: key);

  buildRanks() {
    var items = <Widget>[];
    user.ranks.languages.forEach((key, value) {
      items.add(
        Padding(
          padding:
              EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14.0))),
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    key.substring(0, 1).toUpperCase() + key.substring(1),
                  ),
                  leading: Icon(
                    Icons.code,
                    color: makeCodeWarsColor(value.color),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    value.name,
                    style: TextStyle(color: makeCodeWarsColor(value.color)),
                  ),
                  subtitle: Text(
                    'Name',
                  ),
                ),
                ListTile(
                  title: Text(
                    "${value.score}",
                    style: TextStyle(color: makeCodeWarsColor(value.color)),
                  ),
                  subtitle: Text(
                    'Score',
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildRanks(),
    );
  }
}

class CodeWarsProfileLitePage extends StatefulWidget {
  final String username;

  CodeWarsProfileLitePage({Key key, this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CodeWarsProfileLitePageState(username);
  }
}

class _CodeWarsProfileLitePageState extends State<CodeWarsProfileLitePage> {
  final String username;

  Future<CodeWarsUser> futureUser;

  _CodeWarsProfileLitePageState(this.username);

  @override
  void initState() {
    futureUser = CodeWarsService.requestUser(username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUser,
      builder: (BuildContext context, AsyncSnapshot<CodeWarsUser> user) {
        if (user.connectionState != ConnectionState.waiting) {
          if (user.data != null) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: Container(
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      elevation: 10.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            child: Center(
                                child: CommonShadowContainer(
                              child: Text(
                                "username",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            padding: EdgeInsets.all(16),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                user.data.username,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.transparent,
                    ),
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "images/codewars_content.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(Radius.circular(14.0)),
                    ),
                  ),
                ),
                MessageCard(user: user.data),
                RanksCard(
                  user: user.data,
                )
              ],
            );
          } else {
            return CommonErrorPage(
              onPressed: () {
                setState(() {
                  futureUser = CodeWarsService.requestUser("qiaoyunrui");
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
