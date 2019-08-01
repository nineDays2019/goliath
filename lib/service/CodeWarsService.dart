import 'dart:convert';
import 'dart:io';

class CodeWarsService {
  static queryUser(String idOrUsername) async {
    // todo 需要把网络库封装一下
    var client = new HttpClient();
    var uri =
        new Uri.https('www.codewars.com', "/api/v1/users/:$idOrUsername");
    var request = await client.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    return responseBody;
  }
}

/*
单例模式
class SomeSharedInstance {
  // 单例公开访问点
  factory SomeSharedInstance() =>_sharedInstance()

  // 静态私有成员，没有初始化
  static SomeSharedInstance _instance;

  // 私有构造函数
  SomeSharedInstance._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static SomeSharedInstance _sharedInstance() {
    if (_instance == null) {
      _instance = SomeSharedInstance._();
    }
    return _instance;
  }
}
*/
