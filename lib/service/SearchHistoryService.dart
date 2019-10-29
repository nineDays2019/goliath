import 'package:goliath/main.dart';
import 'package:goliath/service/DBLiteService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static Map<String, SearchHistoryService> _map = {};

  static SearchHistoryService _searchHistoryService(key) {
    SearchHistoryService service;
    if (_map.containsKey(key)) {
      service = _map[key];
    } else {
      service = SearchHistoryService._(key);
      _map.putIfAbsent(key, () => service);
    }
    return service;
  }

  String _key;
  SharedPreferences _preferences;
  List<String> _history;

  SearchHistoryService._(String key) {
    _key = key;
    _init();
  }

  _init() async {
    _preferences = await DBLiteService().getPreferences();
  }

  factory SearchHistoryService(String key) => _searchHistoryService(key);

  clear() {
    _history = null;
    _preferences.remove(_key);
  }

  add(String value) {
    _loadToMemory();
    if (_history == null) {
      _history = [value];
    } else {
      _history.remove(value);
      _history.add(value);
    }
    _writeToDBLite();
  }

  getAll() {
    _loadToMemory();
    return _history;
  }

  _loadToMemory() {
    if (_history == null) {
      _history = _preferences.getStringList(_key);
    }
  }

  _writeToDBLite() {
    if (_history != null) {
      _preferences.setStringList(_key, _history);
    }
  }
}
