class OrgInfoModel {
  String code;
  String agentId;
  String spaceId;
  String orgName;
  String siteName;
  String domain;
  String logoUrl;
  String industryName;
  String sourceId;
  String createTime;
  String shortName;
  String shortLogoUrl;
  String authLevel;
  ServicePriviledge servicePriviledge;
  int packageLevel;
  String packageEndTime;
  ExamQuickSet examQuickSet;
  StudySet studySet;
  PreventScreenRecordeInfo preventScreenRecordeInfo;
  String homePageSet;
  int hasTopLine;
  int userCount;
  int loginUserCount;
  int expectType;
  int isCard;
  String firstIndustryName;
  int isShowCourseMall;
  String orgId;

  OrgInfoModel(
      {this.code,
      this.agentId,
      this.spaceId,
      this.orgName,
      this.siteName,
      this.domain,
      this.logoUrl,
      this.industryName,
      this.sourceId,
      this.createTime,
      this.shortName,
      this.shortLogoUrl,
      this.authLevel,
      this.servicePriviledge,
      this.packageLevel,
      this.packageEndTime,
      this.examQuickSet,
      this.studySet,
      this.preventScreenRecordeInfo,
      this.homePageSet,
      this.hasTopLine,
      this.userCount,
      this.loginUserCount,
      this.expectType,
      this.isCard,
      this.firstIndustryName,
      this.isShowCourseMall,
      this.orgId});

  OrgInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    agentId = json['agentId'];
    spaceId = json['spaceId'];
    orgName = json['orgName'];
    siteName = json['siteName'];
    domain = json['domain'];
    logoUrl = json['logoUrl'];
    industryName = json['industryName'];
    sourceId = json['sourceId'];
    createTime = json['createTime'];
    shortName = json['shortName'];
    shortLogoUrl = json['shortLogoUrl'];
    authLevel = json['authLevel'];
    servicePriviledge = json['servicePriviledge'] != null
        ? new ServicePriviledge.fromJson(json['servicePriviledge'])
        : null;
    packageLevel = json['packageLevel'];
    packageEndTime = json['packageEndTime'];
    examQuickSet = json['examQuickSet'] != null
        ? new ExamQuickSet.fromJson(json['examQuickSet'])
        : null;
    studySet = json['studySet'] != null
        ? new StudySet.fromJson(json['studySet'])
        : null;
    preventScreenRecordeInfo = json['preventScreenRecordeInfo'] != null
        ? new PreventScreenRecordeInfo.fromJson(
            json['preventScreenRecordeInfo'])
        : null;
    homePageSet = json['homePageSet'];
    hasTopLine = json['hasTopLine'];
    userCount = json['userCount'];
    loginUserCount = json['loginUserCount'];
    expectType = json['expectType'];
    isCard = json['isCard'];
    firstIndustryName = json['firstIndustryName'];
    isShowCourseMall = json['isShowCourseMall'];
    orgId = json['orgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['agentId'] = this.agentId;
    data['spaceId'] = this.spaceId;
    data['orgName'] = this.orgName;
    data['siteName'] = this.siteName;
    data['domain'] = this.domain;
    data['logoUrl'] = this.logoUrl;
    data['industryName'] = this.industryName;
    data['sourceId'] = this.sourceId;
    data['createTime'] = this.createTime;
    data['shortName'] = this.shortName;
    data['shortLogoUrl'] = this.shortLogoUrl;
    data['authLevel'] = this.authLevel;
    if (this.servicePriviledge != null) {
      data['servicePriviledge'] = this.servicePriviledge.toJson();
    }
    data['packageLevel'] = this.packageLevel;
    data['packageEndTime'] = this.packageEndTime;
    if (this.examQuickSet != null) {
      data['examQuickSet'] = this.examQuickSet.toJson();
    }
    if (this.studySet != null) {
      data['studySet'] = this.studySet.toJson();
    }
    if (this.preventScreenRecordeInfo != null) {
      data['preventScreenRecordeInfo'] = this.preventScreenRecordeInfo.toJson();
    }
    data['homePageSet'] = this.homePageSet;
    data['hasTopLine'] = this.hasTopLine;
    data['userCount'] = this.userCount;
    data['loginUserCount'] = this.loginUserCount;
    data['expectType'] = this.expectType;
    data['isCard'] = this.isCard;
    data['firstIndustryName'] = this.firstIndustryName;
    data['isShowCourseMall'] = this.isShowCourseMall;
    data['orgId'] = this.orgId;
    return data;
  }
}

class ServicePriviledge {
  int allowEmpUpload;
  int kngAutoAudit;
  int redPacket;
  int studyPlan;
  int exam;
  int showFolder;
  int showFolderKnowledge;
  int hideDynamic;
  int reportNotify;
  int showPlatformKnowledge;
  int workrecord;
  int videoMoveType;
  int receiveLibrary;
  int newKngNotify;

  ServicePriviledge(
      {this.allowEmpUpload,
      this.kngAutoAudit,
      this.redPacket,
      this.studyPlan,
      this.exam,
      this.showFolder,
      this.showFolderKnowledge,
      this.hideDynamic,
      this.reportNotify,
      this.showPlatformKnowledge,
      this.workrecord,
      this.videoMoveType,
      this.receiveLibrary,
      this.newKngNotify});

  ServicePriviledge.fromJson(Map<String, dynamic> json) {
    allowEmpUpload = json['allowEmpUpload'];
    kngAutoAudit = json['kngAutoAudit'];
    redPacket = json['redPacket'];
    studyPlan = json['studyPlan'];
    exam = json['exam'];
    showFolder = json['showFolder'];
    showFolderKnowledge = json['showFolderKnowledge'];
    hideDynamic = json['hideDynamic'];
    reportNotify = json['reportNotify'];
    showPlatformKnowledge = json['showPlatformKnowledge'];
    workrecord = json['workrecord'];
    videoMoveType = json['videoMoveType'];
    receiveLibrary = json['receiveLibrary'];
    newKngNotify = json['newKngNotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowEmpUpload'] = this.allowEmpUpload;
    data['kngAutoAudit'] = this.kngAutoAudit;
    data['redPacket'] = this.redPacket;
    data['studyPlan'] = this.studyPlan;
    data['exam'] = this.exam;
    data['showFolder'] = this.showFolder;
    data['showFolderKnowledge'] = this.showFolderKnowledge;
    data['hideDynamic'] = this.hideDynamic;
    data['reportNotify'] = this.reportNotify;
    data['showPlatformKnowledge'] = this.showPlatformKnowledge;
    data['workrecord'] = this.workrecord;
    data['videoMoveType'] = this.videoMoveType;
    data['receiveLibrary'] = this.receiveLibrary;
    data['newKngNotify'] = this.newKngNotify;
    return data;
  }
}

class ExamQuickSet {
  int trueOrFalseScore;
  int radioScore;
  int checkScore;
  int completionScore;
  int subjectiveScore;

  ExamQuickSet(
      {this.trueOrFalseScore,
      this.radioScore,
      this.checkScore,
      this.completionScore,
      this.subjectiveScore});

  ExamQuickSet.fromJson(Map<String, dynamic> json) {
    trueOrFalseScore = json['trueOrFalseScore'];
    radioScore = json['radioScore'];
    checkScore = json['checkScore'];
    completionScore = json['completionScore'];
    subjectiveScore = json['subjectiveScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trueOrFalseScore'] = this.trueOrFalseScore;
    data['radioScore'] = this.radioScore;
    data['checkScore'] = this.checkScore;
    data['completionScore'] = this.completionScore;
    data['subjectiveScore'] = this.subjectiveScore;
    return data;
  }
}

class StudySet {
  int status;
  int intervals;
  String message;

  StudySet({this.status, this.intervals, this.message});

  StudySet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    intervals = json['intervals'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['intervals'] = this.intervals;
    data['message'] = this.message;
    return data;
  }
}

class PreventScreenRecordeInfo {
  VideoMarquee videoMarquee;
  VideoMarquee documentWatermark;
  VideoMarquee examPaperWatermark;

  PreventScreenRecordeInfo(
      {this.videoMarquee, this.documentWatermark, this.examPaperWatermark});

  PreventScreenRecordeInfo.fromJson(Map<String, dynamic> json) {
    videoMarquee = json['videoMarquee'] != null
        ? new VideoMarquee.fromJson(json['videoMarquee'])
        : null;
    documentWatermark = json['documentWatermark'] != null
        ? new VideoMarquee.fromJson(json['documentWatermark'])
        : null;
    examPaperWatermark = json['examPaperWatermark'] != null
        ? new VideoMarquee.fromJson(json['examPaperWatermark'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videoMarquee != null) {
      data['videoMarquee'] = this.videoMarquee.toJson();
    }
    if (this.documentWatermark != null) {
      data['documentWatermark'] = this.documentWatermark.toJson();
    }
    if (this.examPaperWatermark != null) {
      data['examPaperWatermark'] = this.examPaperWatermark.toJson();
    }
    return data;
  }
}

class VideoMarquee {
  int isShow;
  int showFullname;
  int showJobnumber;
  int showDepartmentName;
  String customText;

  VideoMarquee(
      {this.isShow,
      this.showFullname,
      this.showJobnumber,
      this.showDepartmentName,
      this.customText});

  VideoMarquee.fromJson(Map<String, dynamic> json) {
    isShow = json['isShow'];
    showFullname = json['showFullname'];
    showJobnumber = json['showJobnumber'];
    showDepartmentName = json['showDepartmentName'];
    customText = json['customText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isShow'] = this.isShow;
    data['showFullname'] = this.showFullname;
    data['showJobnumber'] = this.showJobnumber;
    data['showDepartmentName'] = this.showDepartmentName;
    data['customText'] = this.customText;
    return data;
  }
}
