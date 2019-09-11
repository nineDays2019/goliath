import 'dart:convert';
import 'dart:io';

class CodeWarsService {
  static queryUser(String idOrUsername) async {
    // todo 需要把网络库封装一下
    var client = new HttpClient();
    var uri =
        new Uri.https('www.codewars.com', "/api/v1/users/$idOrUsername");
    var request = await client.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    return responseBody;
  }
}
