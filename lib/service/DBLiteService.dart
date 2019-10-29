import 'package:shared_preferences/shared_preferences.dart';

/**
 * 轻量级存储
 */
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

  getPreferences() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  write(String key, String value) async {
    await (await getPreferences()).setString(key, value);
  }

  read(String key) async {
    return await (await getPreferences()).getString(key);
  }

  remove(String key) async {
    (await getPreferences()).remove(key);
  }

}
