import 'package:shared_preferences/shared_preferences.dart';

class DBLiteService {
  static DBLiteService _instance;

  factory DBLiteService() => _sharedInstance();

  DBLiteService._();

  static DBLiteService _sharedInstance() {
    if (_instance == null) {
      _instance = DBLiteService._();
    }
    return _instance;
  }

  SharedPreferences _preferences;

  _getPreferences() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  write(String key, String value) async {
    await (await _getPreferences()).setString(key, value);
  }

  read(String key) async {
    return await (await _getPreferences()).getString(key);
  }

  remove(String key) async {
    (await _getPreferences()).remove(key);
  }
}
