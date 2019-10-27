import 'package:dio/dio.dart';

import 'package:goliath/model/codewars/CodeWarsUser.dart';
import 'package:goliath/service/RequestCacheService.dart';

class CodeWarsService {
  static var dio = new Dio();
  static const BASE_URL = "https://www.codewars.com";
  static var useCache = true;

  /**
   * 读取用户信息
   */
  static Future<CodeWarsUser> requestUser(String idOrUsername) async {
    var url = "$BASE_URL/api/v1/users/$idOrUsername";
    try {
      var response = await Dio().get(url);
      if (useCache) {
        RequestCacheService().put(url, response);
      }
      return new CodeWarsUser.fromJson(response.data);
    } catch (e) {
      print("$url\nerror: $e");
      if (useCache) {
        var cacheResponse = RequestCacheService().get(url);
        if (cacheResponse == null) {
          return null;
        } else {
          return new CodeWarsUser.fromJson(cacheResponse.data);
        }
      } else {
        return null;
      }
    }
  }
}

//https://www.codewars.com/api/v1/users/qiaoyunrui
