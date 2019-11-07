import 'package:goliath/utils/functions.dart';

/**
 * 完后的挑战
 */
class CodeWarsChallengesWrapper {
  int totalPages;
  int totalItems;
  List<CodeWarsChallenge> data;

  CodeWarsChallengesWrapper.fromJson(Map<String, dynamic> json) {
    this.totalItems = json['totalItems'];
    this.totalPages = json['totalPages'];
    data = [];
    json['data'].forEach((item) {
      print(item.toString());
      data.add(CodeWarsChallenge.fromJson(item));
    });
  }
}

class CodeWarsChallenge {
  String id;
  String name;
  String slug;
  String completedAt;
  List<String> completedLanguages;

  CodeWarsChallenge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    completedAt = json['completedAt'];
    completedLanguages = [];
    json['completedLanguages'].forEach((item) {
      completedLanguages.add(item.toString());
    });
  }
}

/**
 * 创作的挑战
 */
class CodeWarsAuthoredChallenge {
  String id;
  String name;
  String description;
  int rank;
  String rankName;
  List<String> tags;
  List<String> languages;

  CodeWarsAuthoredChallenge.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        rank = json['rank'],
        rankName = json['rankName'],
        tags = map2<dynamic, String>(json['tags'], (item) => item.toString()),
        languages =
            map2<dynamic, String>(json['languages'], (item) => item.toString());
}

List<CodeWarsAuthoredChallenge> parseCodeWarsAuthoredChallenges(
        List<dynamic> list) =>
    map2<dynamic, CodeWarsAuthoredChallenge>(
        list, (item) => CodeWarsAuthoredChallenge.fromJson(item));
