import 'package:dio/dio.dart';

class RequestCacheService {
  static const MAX_CACHE_COUNT = 10; // 最大缓存数量

  static RequestCacheService _instance;

  factory RequestCacheService() => _requestCacheService();

  static RequestCacheService _requestCacheService() {
    if (_instance == null) {
      _instance = RequestCacheService._();
    }
    return _instance;
  }

  Map<String, Response<dynamic>> _cache = {};

  RequestCacheService._();

  get(String url) => _cache[url];

  put(String url, Response response) {
    if (_cache.containsKey(url)) {
      _cache[url] = response;
    } else {
      if (_cache.length >= MAX_CACHE_COUNT) {
        _cache.remove(_cache.keys.first);
      }
//      _cache[url] = response;
      _cache.putIfAbsent(url, () => response);
    }
  }
}
