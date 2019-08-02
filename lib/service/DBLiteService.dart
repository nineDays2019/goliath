class DatabaseService {
  static DatabaseService _instance;

  factory DatabaseService() => _sharedInstance();

  /**
   * 私有构造函数
   */
  DatabaseService._() {
    // todo init code
  }

  static DatabaseService _sharedInstance() {
    if (_instance == null) {
      _instance = DatabaseService._();
    }
    return _instance;
  }

}