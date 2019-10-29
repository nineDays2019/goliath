import 'package:dio/dio.dart';
import 'package:goliath/service/RequestCacheService.dart';

Future<T> sampleGet<T>(String url, T converter(Response response),
    {bool useCache: true, bool printLog: true}) async {
  try {
    var response = await Dio().get(url);
    if (useCache) {
      RequestCacheService().put(url, response);
    }
    return converter(response);
  } catch (e) {
    if (printLog) {
      print("url:\t$url,\nerror:\t$e");
    }
    if (useCache) {
      var cacheResponse = RequestCacheService().get(url);
      if (cacheResponse == null) {
        return null;
      } else {
        return converter(cacheResponse);
      }
    }
    return null;
  }
}
