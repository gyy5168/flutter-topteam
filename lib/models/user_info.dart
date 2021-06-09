class UserInfoModel {
  String orgId;
  String code;
  String orgName;
  String domain;
  String userId;
  String token;
  String logoUrl;
  String lastLoginTime;
  int isDefaultPwd;
  String clientKey;
  String deviceId;
  String roleId;
  String mobile;
  int passwordStatus;
  String fullName;
  String imageUrl;
  List<String> roleCodes;

  UserInfoModel(
      {this.orgId,
      this.code,
      this.orgName,
      this.domain,
      this.userId,
      this.token,
      this.logoUrl,
      this.lastLoginTime,
      this.isDefaultPwd,
      this.clientKey,
      this.deviceId,
      this.roleId,
      this.mobile,
      this.passwordStatus,
      this.fullName,
      this.imageUrl,
      this.roleCodes});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    orgId = json['orgId'];
    code = json['code'];
    orgName = json['orgName'];
    domain = json['domain'];
    userId = json['userId'];
    token = json['token'];
    logoUrl = json['logoUrl'];
    lastLoginTime = json['lastLoginTime'];
    isDefaultPwd = json['isDefaultPwd'];
    clientKey = json['clientKey'];
    deviceId = json['deviceId'];
    roleId = json['roleId'];
    mobile = json['mobile'];
    passwordStatus = json['passwordStatus'];
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
    roleCodes = json['roleCodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orgId'] = this.orgId;
    data['code'] = this.code;
    data['orgName'] = this.orgName;
    data['domain'] = this.domain;
    data['userId'] = this.userId;
    data['token'] = this.token;
    data['logoUrl'] = this.logoUrl;
    data['lastLoginTime'] = this.lastLoginTime;
    data['isDefaultPwd'] = this.isDefaultPwd;
    data['clientKey'] = this.clientKey;
    data['deviceId'] = this.deviceId;
    data['roleId'] = this.roleId;
    data['mobile'] = this.mobile;
    data['passwordStatus'] = this.passwordStatus;
    data['fullName'] = this.fullName;
    data['imageUrl'] = this.imageUrl;
    data['roleCodes'] = this.roleCodes;
    return data;
  }
}
