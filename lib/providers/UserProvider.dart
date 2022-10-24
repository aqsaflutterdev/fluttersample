import 'package:flutter/cupertino.dart';
import 'package:practiceflutter/domain/User.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      email: '',
      //avatar: '',
      firstname: '',
      lastname: '',
      phonenumber: '',
      currency: '',
      password: '',
      token: '',
      username: '',
      avatar: '',
      phoneseparated: '',
      avatarpath: '',
      country_code: '');
  User get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }


}