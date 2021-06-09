import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topteam/common/global.dart';
import 'package:topteam/common/utils.dart';
import 'package:topteam/common/widgets.dart';
import 'package:topteam/pages/manage/exam/list.dart';
import 'package:topteam/services/main.dart';
import 'package:topteam/widgets/form_item.dart';
import 'package:topteam/widgets/form_item_group.dart';

class ExamCreate extends StatefulWidget {
  @override
  _ExamCreateState createState() => _ExamCreateState();
}

class _ExamCreateState extends State<ExamCreate> {
  var exam = {
    'logoUrl': 'https://picddo.yxt.com/g/train/cover-exam-default.jpg',
    'name': '',
    'startTime': '',
    'endTime': '',
    'isPublish': 1,
    'isReview': 1,
    'clientType': 0,
    'breakNum': 3,
    'isFaceVerify': 0,
    'isSubjectShuffle': 0,
    'isItemShuffle': 0,
    'studyPoints': 0,
    'standard': 1,
    'auditorId': [Global.userId],
    'isAnonymAudit': 1,
    'status': 1,
    'scoreType': 0,
    'certificateId': []
  };
  var attendee = [];
  var limitStage = false;
  var paper = {
    'pid': 'adcb5c74-f219-4c20-b06e-33eaa2a83236',
    'name': 'gy删除试题1118',
    'type': 1,
    'description': '',
    'status': 1,
    'knowledgeId': '',
    'creator': '55110367-708e-491b-9e46-31b39bca2fa3',
    'createTime': '2020-11-18 17:29:58.0',
    'creatorName': '顾阳',
    'subjectCount': 5,
    'trueOrFalseCount': 1,
    'radioCount': 1,
    'checkCount': 1,
    'completionCount': 1,
    'subjectiveCount': 1,
    'totalScore': 31,
    'typeInfoList': null,
    'isPrivate': 0,
    'path': null,
    'pathName': null,
    'checked': true,
    'disabled': false
  };

  // TextEditingController limitController = TextEditingController();

  @override
  void initState() {
    exam['auditorId'] = [Global.userId];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('安排考试'),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xfffafafa),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: AspectRatio(
                        aspectRatio: 690 / 258,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                image: DecorationImage(
                                  image: NetworkImage(exam['logoUrl'])
                                )
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 36,
                                color: Color.fromRGBO(0, 0, 0, .4),
                                alignment: Alignment.center,
                                child: AppText('更换封面', color: Colors.white,),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                    FormItemGroup(
                      children: [
                        FormItem(
                          value: exam['name'],
                          hintText: '请输入考试名称(必填)',
                          maxLength: 50,
                          onChanged: (value) {
                            exam['name'] = value;
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    FormItemGroup(
                      children: [
                        FormItem(
                          label: '开始时间',
                          value: exam['startTime'],
                          hintText: '请选择(必填)',
                          readOnly: true,
                          onTap: () async {
                            // final picker = CupertinoDatePicker(
                            //   onDateTimeChanged: (dateTime) {
                            //     print(dateTime);
                            //   }
                            // );
                    
                            // showCupertinoModalPopup(context: context, builder: (context){
                            //   return Container(
                            //     color: Color(0xffffffff),
                            //     height: 300,
                            //     child: picker,
                            //   );
                            // });

                            var picker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2016),
                              lastDate: DateTime(2099),
                              locale: Locale('zh')
                            );
                            setState(() {
                              exam['startTime'] = picker == null ? '' : dateFormat(picker.toString(), 'yyyy-MM-dd HH:mm');
                            });
                          },
                          suffix: true,
                        ),
                        FormItem(
                          label: '结束时间',
                          value: exam['endTime'],
                          hintText: '请选择(必填)',
                          readOnly: true,
                          onTap: () async {
                            var picker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2016),
                              lastDate: DateTime(2099),
                              locale: Locale('zh')
                            );
                            setState(() {
                              exam['endTime'] = picker == null ? '' : dateFormat(picker.toString(), 'yyyy-MM-dd HH:mm');
                            });
                          },
                          suffix: true,
                        ),
                        FormItem(
                          label: '单次限时',
                          hintText: '不限',
                        ),
                        FormItem(
                          label: '限考次数',
                          hintText: '不限',
                          suffix: true,
                        ),
                        FormItem(
                          label: '最终成绩',
                          suffix: true,
                          readOnly: true,
                          value: '取考生最后一次考试的得分',
                        ),
                        FormItem(
                          label: '选择试卷',
                          hintText: '请选择',
                          suffix: true,
                          value: paper['name']
                        ),
                        FormItem(
                          label: '通过分数',
                          hintText: '必填',
                          digitsOnly: true,
                          max: paper['totalScore'],
                          value: paper['standard']
                        ),
                        FormItem(
                          label: '通过证书',
                          hintText: '请选择',
                          suffix: true,
                        ),
                        FormItem(
                          label: '学分奖励',
                          value: exam['studyPoints'],
                          hintText: '',
                        ),
                        FormItem(
                          label: '公开成绩榜',
                          value: exam['isPublish'],
                          activeSwitchValue: 1,
                          inactiveSwitchValue: 0,
                          onChanged: (value) {
                            setState(() {
                              exam['isPublish'] = value;
                            });
                          },
                          select: true,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 8, left: 15, right: 15),
                      child: AppText('防作弊设置', fontSize: 12, color: Color(0xffaaaaaa),)
                    ),
                    FormItemGroup(
                      children: [
                        FormItem(
                          label: '允许回顾答题',
                          value: exam['isReview'],
                          activeSwitchValue: 1,
                          inactiveSwitchValue: 0,
                          onChanged: (value) {
                            setState(() {
                              exam['isReview'] = value;
                            });
                          },
                          select: true,
                        ),
                        FormItem(
                          label: '正确答案',
                          hintText: '请选择',
                          suffix: true,
                        ),
                        FormItem(
                          label: '仅限手机端参与',
                          value: exam['clientType'],
                          activeSwitchValue: 1,
                          inactiveSwitchValue: 0,
                          onChanged: (value) {
                            setState(() {
                              exam['clientType'] = value;
                              if (value == 0) {
                                limitStage = false;
                                exam['breakNum'] = null;
                                exam['isFaceVerify'] = 0;
                              }
                            });
                          },
                          select: true,
                        ),
                        FormItem(
                          label: '限制考试中断',
                          value: limitStage,
                          onChanged: (value) {
                            setState(() {
                              limitStage = value;
                              if (value) {
                                exam['clientType'] = 1;
                                exam['breakNum'] = 3;
                              }
                            });
                          },
                          select: true,
                        ),
                        FormItem(
                          // controller: limitController,
                          // focusNode: limitFocusNode,
                          value: exam['breakNum'],
                          keyboardType: TextInputType.number,
                          stage: limitStage,
                          label: '中断次数',
                          hintText: '必填',
                          max: 99,
                          min: 1,
                          digitsOnly: true,
                          onChanged: (value) {
                            exam['breakNum'] = value;
                            // setState(() {
                            //   exam['breakNum'] = value;
                            // });
                          },
                        ),
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
                      child: AppText('应用之间切换，home键切换到后台、点击返回退出考试、电话中断、上传图片等行为均视为考试中断。超过次数后员工的试卷将会被提交。', fontSize: 12, color: Color(0xffaaaaaa),)
                    ),
                    FormItemGroup(
                      children: [
                        FormItem(
                          label: '人脸识别',
                          disabled: true,
                          value: exam['isFaceVerify'],
                          activeSwitchValue: 1,
                          inactiveSwitchValue: 0,
                          onChanged: (value) {
                            setState(() {
                              exam['isFaceVerify'] = value;
                            });
                          },
                          select: true,
                        ),
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: '升级', style: TextStyle(fontSize: 12, color: Color(0xffaaaaaa))),
                            TextSpan(text: '专业版', style: TextStyle(fontSize: 12, color: Color(0xff3c8cfa))),
                            TextSpan(text: '，开启人脸识别功能及更多功能特权', style: TextStyle(fontSize: 12, color: Color(0xffaaaaaa)))
                          ]
                        ),
                      )
                      // child: AppText('升级专业版，开启人脸识别功能及更多功能特权', fontSize: 12, color: Color(0xffaaaaaa),)
                    ),
                    FormItemGroup(
                      children: [
                        FormItem(
                          label: '试题顺序打乱',
                          value: exam['isSubjectShuffle'],
                          activeSwitchValue: 1,
                          inactiveSwitchValue: 0,
                          onChanged: (value) {
                            setState(() {
                              exam['isSubjectShuffle'] = value;
                            });
                          },
                          select: true,
                        ),
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
                      child: AppText('试题顺序随机生成，防止考试作弊。', fontSize: 12, color: Color(0xffaaaaaa),)
                    ),
                    FormItemGroup(
                      children: [
                        FormItem(
                          label: '选项顺序打乱',
                          value: exam['isItemShuffle'],
                          activeSwitchValue: 1,
                          inactiveSwitchValue: 0,
                          onChanged: (value) {
                            setState(() {
                              exam['isItemShuffle'] = value;
                            });
                          },
                          select: true,
                        ),
                      ]
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Color(0xfff2f2f2)))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 48,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Expanded(child: AppText('考试人员', fontSize: 17, fontWeight: FontWeight.w700,)),
                                Offstage(
                                  offstage: attendee.length == 0,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: AppText('${attendee.length}名人员', color: Color(0xff999999), fontSize: 12,),
                                  ),
                                ),
                                GestureDetector(child: AppText('添加人员', color: Color(0xff3c8cfa), fontSize: 12,), onTap: selectUser,)
                              ],
                            ),
                          ),
                          Offstage(
                            offstage: attendee.length == 0,
                            child: Wrap(
                              children: attendee.map((item) {
                                return Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          image: DecorationImage(image: NetworkImage(item['avatar']))
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 4, left: 7, right: 7),
                                        height: 38,
                                        child: Text(item['name'], overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Offstage(
                            offstage: attendee.length == 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: GestureDetector(child: AppText('清空全部', fontSize: 12,), onTap: clearUser,),
                                    )
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 32,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xffe4e4e4)),
                                        borderRadius: BorderRadius.circular(4),
                                        // color: Color(0xff3c8cfa)
                                      ),
                                      child: AppText('添加考试人员', fontSize: 12),
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),
                          Offstage(
                            offstage: attendee.length == 0,
                            child: SizedBox(height: 15,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xfff2f2f2)))
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: AppText('暂时保存', fontSize: 18, fontWeight: FontWeight.w700)
                      )
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff3c8cfa)
                          ),
                          child: AppText('保存并发布', color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        onTap: submit,
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void selectUser() {
    var self = {
      'type': 1,
      'id': Global.userInfo.userId,
      'avatar': Global.userInfo.imageUrl,
      'count': 0,
      'name': Global.userInfo.fullName
    };
    setState(() {
      attendee.clear();
      attendee.add(self);
    });
  }

  void clearUser() {
    setState(() {
      attendee.clear();
    });
  }

  submit() {
    var data = jsonDecode(jsonEncode(exam));
    data['paperTemplateId'] = [paper['pid']];
    data['startTime'] = data['startTime'] + ':00';
    data['endTime'] = data['endTime'] + ':00';
    data['attendee'] = attendee.map((item) => 'person|${item['id']}').join(';');
    createExam(data).then((res) {
      Navigator.pop(context);
    }).catchError((err) {
      print(err.response);
    });
  }
}