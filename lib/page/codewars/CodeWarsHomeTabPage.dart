import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goliath/page/codewars/CodeWarsProfilePage.dart';

import 'CodeWarsChallengeListPage.dart';

class CodeWarsHomeTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CodeWarsHomeTabState();
}

class _CodeWarsHomeTabState extends State<CodeWarsHomeTabPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    _profilePage = new CodeWarsProfilePage();
    super.initState();
  }

  Widget _profilePage;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          Text(
            'Index 0: Home',
            style: optionStyle,
          ),
          CodeWarsChallengeListPage(
            id: "qiaoyunrui",
            name: "juhezi",
          ),
          _profilePage
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
