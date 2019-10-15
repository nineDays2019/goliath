import 'package:flutter/material.dart';
import 'package:goliath/deprecated/SearchPage.dart';
import 'package:goliath/service/AccountService.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homeDrawer(context);
  }

  static Widget homeDrawer(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        drawerHeader(),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: AssetImage('images/codewars.jpg'),
            ),
            title: new Text("CodeWars"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CodeWarsSearchPage()));
            },
          ),
        ),
        new ListTile(
          leading: new CircleAvatar(
            child: new Text("B"),
          ),
          title: new Text("Drawer item B"),
          subtitle: new Text("Nice to meet you"),
          onTap: () {},
        ),
        new AboutListTile(
          icon: new CircleAvatar(child: new Text("Ab")),
          child: new Text("关于"),
          applicationName: "今天做点什么",
          applicationVersion: "1.0",
          applicationIcon: new Image.asset(
            'images/tan.jpg',
            width: 50.0,
            height: 50.0,
          ),
          aboutBoxChildren: <Widget>[
            new Text("谢谢大家"),
          ],
        ),
      ],
    );
  }

  static Widget drawerHeader() {
    getNickname() {
      var service = AccountService.getInstance();
      if (service.online()) {
        return service.currentAccount().getNickname();
      } else {
        return "未登录";
      }
    }

    return new UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      accountName: new Text(
        getNickname(),
      ),
      accountEmail: new Text("Juhezix@163.com"),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/tan.jpg'),
      ),
      onDetailsPressed: () {},
      otherAccountsPictures: <Widget>[
        new CircleAvatar(
          backgroundImage: AssetImage('images/tan.jpg'),
        )
      ],
    );
  }
}
