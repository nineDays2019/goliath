import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;

import 'CodeWarsProfilePage.dart';

/**
 * CodeWars 搜索页
 */
class CodeWarsSearchDelegate extends SearchDelegate<String> {
  static const DB_NAME = "CodeWarsHistory";

  final List<String> _words;

  CodeWarsSearchDelegate()
      : _words = List.from(Set.from(words.all))
          ..sort((w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()));

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
    return CodeWarsProfileLitePage(username: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions =
        _words.where((word) => word.startsWith(query));
    return _CodeWarsSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (suggestion) {
        // 添加搜索历史
        query = suggestion;
        showResults(context);
      },
    );
  }
}

class _CodeWarsSuggestionList extends StatelessWidget {
  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  const _CodeWarsSuggestionList(
      {this.suggestions, this.query, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int i) {
          final String suggestion = suggestions[i];
          return ListTile(
              leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
              title: RichText(
                text: TextSpan(
                  text: suggestion.substring(0, query.length),
                  style: textTheme.copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: suggestion.substring(query.length),
                      style: textTheme,
                    )
                  ],
                ),
              ),
              onTap: () => onSelected(suggestion));
        });
  }
}
