import 'package:dio/dio.dart';
import 'package:topteam/common/global.dart';
import 'package:topteam/common/request.dart';

accountLogin (data) => Request().post('global/tokens', data: data);
getBanners ({query}) => Request().get('orgs/${Global.orgId}/banners', query: query);
getTodos (query) => Request().get('orgs/${Global.orgId}/orgusers/${Global.userId}/todolist', query: query);
getStudyHonor (query) => Request().get('studyreports/topStudyHours', query: query);
getOrgInfo () => Request().get('orgs/${Global.orgId}');
getHourRank (query) => Request().get('orgs/${Global.orgId}/knowledges/allstudyhoursrank', query: query);
getPointRank (query) => Request().get('orgs/${Global.orgId}/knowledges/topstudyhoursrank', query: query);
getExamList (query) => Request().get('exams', query: query);
createExam (data) => Request().post('exams', data: data);
getKngList (query) => Request().get('orgs/${Global.orgId}/knowledges/searchAllPublicKnowledge', query: query);
getKngDetail(id, {query}) => Request().get('orgs/${Global.orgId}/users/${Global.userId}/knowledges/$id', query: query);
getKngPalyInfo(query) => Request(type: 'component').get('config/migrate', query: query);