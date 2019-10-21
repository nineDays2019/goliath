import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:goliath/model/codewars/CodeWarsUser.dart';

class CodeWarsService {
  static var dio = new Dio();
  static const BASE_URL = "https://www.codewars.com";

  /**
   * 读取用户信息
   */
  static Future<CodeWarsUser> requestUser(String idOrUsername) async {
    var url = "$BASE_URL/api/v1/users/$idOrUsername";
    try {
      var response = await Dio().get(url);
//      print("return: ${response.data}");
      return new CodeWarsUser.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
    /*if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        return new CodeWarsUser();
      } else {
        print("Not OK");
        return null;
      }*/
  }
}

//https://www.codewars.com/api/v1/users/qiaoyunrui
