import 'package:flutter/material.dart';
import 'package:guardian_view/src/auth/data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;
  LocalUserModel? get user => _user;
  void initUser(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
    }
  }

  // change the user when somthing changes
  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
