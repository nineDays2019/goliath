class CodeWarsUser {
  String username;
  String name;
  int honor;
  String clan;
  num leaderboardPosition;
  List<String> skills = []; // 暂时不知道是什么数据结构
  CodeWarsRank ranks;
  CodeWarsChallenges codeChallenges;

  CodeWarsUser.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'],
        honor = json['honor'],
        clan = json['clan'],
        ranks = CodeWarsRank.fromJson(json['ranks']),
        codeChallenges = CodeWarsChallenges.fromJson(json['codeChallenges']);
}

class CodeWarsRank {
  CodeWarsLanguage overall;
  Map<String, CodeWarsLanguage> languages = {};

  CodeWarsRank.fromJson(Map<String, dynamic> json) {
    overall = CodeWarsLanguage.fromJson(json['overall']);
    languages = json['languages'].map<String, CodeWarsLanguage>((key, value) {
      return MapEntry(key.toString(), CodeWarsLanguage.fromJson(value));
    });
  }
}

class CodeWarsChallenges {
  int totalAuthored;
  int totalCompleted;

  CodeWarsChallenges.fromJson(Map<String, dynamic> json)
      : totalAuthored = json['totalAuthored'],
        totalCompleted = json['totalCompleted'];
}

class CodeWarsLanguage {
  int rank;
  String name;
  String color;
  int score;

  CodeWarsLanguage.fromJson(Map<String, dynamic> json)
      : rank = json['rank'],
        name = json['name'],
        color = json['color'],
        score = json['score'];
}
