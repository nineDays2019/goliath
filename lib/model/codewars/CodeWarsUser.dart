class CodeWarsUser {
  String username;
  String name;
  int honor;
  String clan;
  num leaderboardPosition;
  List<String> skills = []; // 暂时不知道是什么数据结构
  CodeWarsRank ranks;
  CodeWarsChallenges codeChallenges;
}

class CodeWarsRank {
  CodeWarsLanguage overall;
  List<CodeWarsLanguage> languages = [];
}

class CodeWarsChallenges {
  int totalAuthored;
  int totalCompleted;
}

class CodeWarsLanguage {
  int rank;
  String name;
  String color;
  int score;
}
