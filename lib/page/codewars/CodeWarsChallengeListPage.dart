import 'package:flutter/material.dart';
import 'package:goliath/model/codewars/CodeWarsChallengesWrapper.dart';
import 'package:goliath/page/common/CommonErrorPage.dart';
import 'package:goliath/page/common/CommonLoadingPage.dart';
import 'package:goliath/service/CodeWarsService.dart';

/**
 * 最后会变成一个公用的 CodeWars Challenge 列表
 * 先这样凑合一下
 */
class CodeWarsChallengeListPage extends StatelessWidget {
  String id;
  String name;

  CodeWarsChallengeListPage({Key key, this.id, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$name's Challenges"),
      ),
      body: _ChallengeListPage(id),
    );
  }
}

class _ChallengeListPage extends StatefulWidget {
  String id;
  String page;

  _ChallengeListPage(this.id);

  @override
  State<StatefulWidget> createState() => _ChallengeListState(id);
}

class _ChallengeListState extends State<_ChallengeListPage> {
  String id;
  int page = 0;

  Future<CodeWarsChallengesWrapper> futureChallengesWrapper;

  _ChallengeListState(this.id);

  @override
  void initState() {
    futureChallengesWrapper =
        CodeWarsService.requestChallenge(id, page: this.page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureChallengesWrapper,
      builder: (BuildContext context,
          AsyncSnapshot<CodeWarsChallengesWrapper> wrapper) {
        if (wrapper.connectionState != ConnectionState.waiting) {
          if (wrapper.data != null) {
            _wrapper = wrapper.data;
            return ListView.builder(
                itemBuilder: buildItem, itemCount: _wrapper.data.length);
          } else {
            return CommonErrorPage(
                onPressed: () => setState(() {
                      futureChallengesWrapper =
                          CodeWarsService.requestChallenge(id, page: this.page);
                    }));
          }
        } else {
          return CommonLoadingPage();
        }
      },
    );
  }

  CodeWarsChallengesWrapper _wrapper;

  Widget buildItem(BuildContext context, int index) {
    var name = _wrapper.data[index].name;
    var length = _wrapper.data.length;
    if (name == null || name.isEmpty) {
      name = "No Name";
    }
    var child = <Widget>[
      ListTile(
        leading: CircleAvatar(
          child: Text(name.toUpperCase().substring(0, 1)),
        ),
        title: Text(name),
        subtitle: Text(_wrapper.data[index].completedAt.substring(0, 10)),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      Padding(
        padding: new EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children:
                createLanguagesWidgets(_wrapper.data[index].completedLanguages),
          ),
        ),
      )
    ];
    if (index != length - 1) {
      child.add(Divider());
    }
    return Column(
      children: child,
    );
  }
}

createLanguagesWidgets(List<String> languages) {
  if (languages == null) return <Widget>[];
  List<Widget> widgets = [];
  for (var language in languages) {
    widgets.add(Chip(
      avatar: new CircleAvatar(
        backgroundColor: Colors.lightBlue,
        child: Text(language.toUpperCase().substring(0, 1)),
      ),
      label: Text(language),
    ));
  }
  return widgets;
}

// todo 解析时间
