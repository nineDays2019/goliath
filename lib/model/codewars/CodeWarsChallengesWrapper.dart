import 'package:flutter/material.dart';

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
