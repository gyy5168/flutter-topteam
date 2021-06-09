import 'dart:convert';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:topteam/common/utils.dart';
import 'package:topteam/common/widgets.dart';
import 'package:topteam/pages/manage/exam/create.dart';
import 'package:topteam/services/main.dart';

class ExamManage extends StatefulWidget {
  ExamManage({Key key}) : super(key: key);

  @override
  _ExamManageState createState() => _ExamManageState();
}

class _ExamManageState extends State<ExamManage> {
  var exam = DataList(pageSize: 10, loading: true);
  @override
  void initState() {
    super.initState();
    this.getList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: Text('首页'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExamCreate()));
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: Text('+ 安排', style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
      body: Container(
        // color: Color(0xfffafafa),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xfff2f2f2),
                    width: 1
                  )
                )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 35,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Color(0xfff6f6f6),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: TextField(
                        cursorColor: Color(0xff666666),
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Color(0xff666666), size: 20,),
                          prefixIconConstraints: BoxConstraints(maxWidth: 35, minWidth: 35, maxHeight: 36, minHeight: 36),
                          hintText: '请输入考试名称',
                          hintStyle: TextStyle(color: Color(0xffcccccc)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero
                        ),
                      ),
                    )
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.reorder, color: Color(0xff666666)),
                  )
                ],
              ),
            ),
            Expanded(
              child: buildList(),
            ),
          ],
        ),
      )
    );
  }

  buildList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: MediaQuery.of(context).padding.bottom),
      itemCount: exam.list.length + 1,
      itemBuilder: (context, index) {
        if (index == exam.list.length) {
          if (exam.loading || exam.pages > exam.pageIndex) {
            if (!exam.loading) getList();
            return Column(
              children: [
                CircularProgressIndicator()
              ],
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text('我也是有底线的～'),
            );
          }
        }

        var item = exam.list[index];
        return GestureDetector(
          onTap: () {
            print(item);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffe4e4e4)
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    image: DecorationImage(
                      image: NetworkImage(item['logoUrl']),
                      fit: BoxFit.cover,
                    )
                  )
                ),
                Container(
                  // height: 140,
                  child: Column(children: [
                    SizedBox(height: 14),
                    Row(children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(item['examName'], overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(height: 20/17, fontSize: 17))
                        ),
                      ),
                      buildExamStatus(item)
                    ]),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            margin: EdgeInsets.only(left: 15,right: 15),
                            child: Text(dateFormat(item['startTime'], 'MM-dd HH:mm') + ' 至 ' + dateFormat(item['endTime'], 'MM-dd HH:mm'), style: TextStyle(color: Color(0xff49af4a), fontSize: 12),),
                            decoration: BoxDecoration(
                              color: Color(0xffedf7ed),
                              borderRadius: BorderRadius.all(Radius.circular(2))
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(item['totalAttendeeNum'].toString()),
                                AppText('应考人数', fontSize: 11, color: Color(0xff999999))
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(item['actualAttendeeNum'].toString()),
                                AppText('实考人数', fontSize: 11, color: Color(0xff999999)),
                              ],
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(minWidth: 50),
                            child: Offstage(
                              offstage: !((item['auditStatus'] == 0 || item['auditStatus'] == 3) && item['status'] == 2),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(progressFormat(item['passRate'] * 100).toString()),
                                      AppText('%', fontSize: 11, color: Color(0xff999999)),
                                    ],
                                  ),
                                  AppText('通过率', fontSize: 11, color: Color(0xff999999)),
                                ],
                              ),
                            ),
                          )
                        ]
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(
                          color: Color(0xffe4e4e4)
                        ))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(item['status'] != 0 ? Icons.remove_red_eye_outlined : Icons.near_me, size: 16, color: Color(0xff333333),),
                                SizedBox(width: 6),
                                Container(
                                  alignment: Alignment.center,
                                  child: AppText(item['status'] != 0 ? '查看' : '发布', fontSize: 12,)
                                )
                              ],
                            )
                          ),
                          VerticalDivider(
                            color: Color(0xffe4e4e4),
                            width: 1,
                            thickness: 1,
                            indent: 12,
                            endIndent: 12,
                          ),
                          Expanded(
                            child: Popper(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.more_horiz, size: 16),
                                  SizedBox(width: 6),
                                  Container(
                                    alignment: Alignment.center,
                                    child: AppText('更多', fontSize: 12,)
                                  ),
                                ],
                              ),
                              offset: -5,
                              content: [
                                PopperItem(
                                  stage: item['status'] == 1,
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: AppText('DING')
                                  ),
                                  onTap: () {
                                    print('DING');
                                  }
                                ),
                                PopperItem(
                                  stage: item['status'] == 1,
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: AppText('分享链接')
                                  ),
                                  onTap: () {
                                    print('分享链接');
                                  }
                                ),
                                PopperItem(
                                  stage: item['status'] != 0 && item['isOpen'] == 0,
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: AppText('公布答案')
                                  ),
                                  onTap: () {
                                    print('公布答案');
                                  }
                                ),
                                PopperItem(
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: AppText('复制')
                                  ),
                                  onTap: () {
                                    print('复制');
                                  }
                                ),
                                PopperItem(
                                  stage: item['status'] != 4 && item['status'] != 0 && item['status'] != 2,
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: AppText('结束')
                                  ),
                                  onTap: () {
                                    print('结束');
                                  }
                                ),
                                PopperItem(
                                  stage: item['status'] == 0 || item['status'] == 2,
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: AppText('删除')
                                  ),
                                  onTap: () {
                                    print('删除');
                                  }
                                )
                              ],
                              contentWidth: 105
                            )
                          )
                        ],
                      )
                    )
                  ]),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Container buildExamStatus(exam) {
    var textColor = 0xff333333;
    var backgroundColor = 0xfff9f9f9;
    var statusText = '已完成';
    if (exam['status'] == 0) {
      backgroundColor = 0xfff0f0f0;
      statusText = '待发布';
    } else if (exam['status'] == 1) {
      var now = DateTime.now();
      if (now.isBefore(DateTime.parse(exam['startTime']))) {
        backgroundColor = 0xfff0f0f0;
        statusText = '未开始';
      } else if (now.isAfter(DateTime.parse(exam['endTime']))) {
        statusText = '已过期';
      } else {
        textColor = 0xff3c8cfa;
        backgroundColor = 0xffecf4ff;
        statusText = '进行中';
      }
    } else {
      if (exam['auditStatus'] == 1) {
        textColor = 0xfffa9600;
        backgroundColor = 0xfffff5e6;
        statusText = '待批阅';
      } else if (exam['auditStatus'] == 2) {
        textColor = 0xfffa9600;
        backgroundColor = 0xfffff5e6;
        statusText = '批阅中';
      }
    }
    return Container(
      width: 60,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))
      ),
      child: Text(statusText, style: TextStyle(fontSize: 12, color: Color(textColor)),)
    );
  }

  void getList() {
    exam.pageIndex++;
    exam.loading = true;
    getExamList(exam.paging).then((res) {
      var data = jsonDecode(res.toString());
      exam.loading = false;
      exam.list.addAll(data['datas']);
      exam.pages = data['paging']['pages'];
      exam.count = data['paging']['count'];
      setState(() {});
    }).catchError((err) {
      exam.loading = false;
      setState(() {});
    });
  }
}