// 账户相关

import 'package:goliath/model/User.dart';

class AccountService {
  static AccountService _instance;

  static AccountService getInstance() {
    if (_instance == null) {
      _instance = new AccountService();
    }
    return _instance;
  }

  var _online = false;
  User _currentAccount;

  online() {
    return _online;
  }

  currentAccount() {
    return _currentAccount;
  }

  signIn(User user) {
    this._currentAccount = user;
    _online = _currentAccount != null;
  }

  signOut() {
    _currentAccount = null;
    _online = false;
  }
}
