import 'package:flutter/material.dart';
import 'package:goliath/model/codewars/CodeWarsChallengesWrapper.dart';
import 'package:goliath/page/common/CommonErrorPage.dart';
import 'package:goliath/page/common/CommonLoadingPage.dart';
import 'package:goliath/service/CodeWarsService.dart';

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
//            return Text("HelloWorld");
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
    /*if (index.isOdd) {
      return new Divider();
    }
    var textStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text("Name: ", style: textStyle),
    );*/
    return ListTile(
      title: Text(_wrapper.data[index].name),
    );
  }
}
