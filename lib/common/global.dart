import 'package:shared_preferences/shared_preferences.dart';
import 'package:topteam/models/org_info.dart';
import 'package:topteam/models/user_info.dart';

class Global {
  static SharedPreferences prefs;
  static String userId;
  static String orgId;
  static String token;
  static UserInfoModel userInfo;
  static OrgInfoModel orgInfo; 
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }
  static setUserInfo(userInfo) {
    Global.userInfo = UserInfoModel.fromJson(userInfo);
    Global.token = userInfo['token'];
    Global.userId = userInfo['userId'];
    Global.orgId = userInfo['orgId'];
  }
  static setOrgInfo(orgInfo) {
    Global.orgInfo = OrgInfoModel.fromJson(orgInfo);
  }
}