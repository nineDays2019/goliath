import 'package:dio/dio.dart';
import 'package:goliath/model/codewars/CodeWarsChallengesWrapper.dart';

import 'package:goliath/model/codewars/CodeWarsUser.dart';
import 'package:goliath/service/RequestCacheService.dart';
import 'package:goliath/utils/request_utils.dart';

class CodeWarsService {
  static var dio = new Dio();
  static const BASE_URL = "https://www.codewars.com";
  static var useCache = true;

  /**
   * 读取用户信息
   * https://www.codewars.com/api/v1/users/qiaoyunrui
   */
  static Future<CodeWarsUser> requestUser(String idOrUsername) async {
    var url = "$BASE_URL/api/v1/users/$idOrUsername";
    return await sampleGet<CodeWarsUser>(
        url, (Response response) => CodeWarsUser.fromJson(response.data));
  }

  /**
   * 获取用户 Challenge 信息
   * https://www.codewars.com/api/v1/users/qiaoyunrui/code-challenges/completed?page=0
   */
  static Future<CodeWarsChallengesWrapper> requestChallenge(String idOrUsername,
      {int page = 0}) async {
    var url =
        "$BASE_URL/api/v1/users/$idOrUsername/code-challenges/completed?page=$page";
    return await sampleGet<CodeWarsChallengesWrapper>(
        url,
        (Response response) =>
            CodeWarsChallengesWrapper.fromJson(response.data));
  }
}
