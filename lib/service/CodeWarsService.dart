import 'dart:convert';
import 'dart:io';

import 'package:goliath/model/codewars/CodeWarsUser.dart';

class CodeWarsService {
  static const BASE_URL = "https://www.codewars.com";

  /**
   * 读取用户信息
   */
  static Future<CodeWarsUser> requestUser(String idOrUsername) async {
    var url = "$BASE_URL/api/v1/users/$idOrUsername";
    var httpClient = new HttpClient();
    CodeWarsUser user;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        return new CodeWarsUser();
      } else {
        print("Not OK");
        return null;
      }
    } catch (exception) {
      print("[error]: " + exception.toString());
      return null;
    }
  }
}

//https://www.codewars.com/api/v1/users/qiaoyunrui
