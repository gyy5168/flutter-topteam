import 'package:flutter/material.dart';

import 'package:topteam/models/user_info.dart';

class UserInfo extends ChangeNotifier {
  UserInfoModel _userInfo;
  UserInfoModel get () => _userInfo ?? null;
  void setUserInfo(userInfo){
    _userInfo = UserInfoModel.fromJson(userInfo);
    notifyListeners();
  }
}