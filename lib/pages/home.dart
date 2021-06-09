

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:topteam/common/global.dart';
import 'package:topteam/common/utils.dart';
import 'package:topteam/services/main.dart';

import 'home/guides.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todo = DataList(pageSize: 20);
  var recommend = DataList(pageIndex: 1);
  @override
  void initState() {
    super.initState();
    getTodoList();
    getRecommend();
  }

  @override
  Widget build(BuildContext context) {
    // var userInfo = Provider.of<UserInfo>(context).get();
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            SizedBox(height: 10),
            buildBanners(),
            SizedBox(height: 20),
            buildFuctionEntries(),
            HomeGuides(),
            buildTodos(),
            buidRecommend(),
            buildHonor(),
            buildMonthPointRank(),
            buildTotalHourRank()
          ],
        ),
      )
    );
  }

  Widget buildBanners() {
    return FutureBuilder(
      future: getBanners(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var banners;
          if (snapshot.hasError) {
            banners = [];
          } else {
            banners = jsonDecode(snapshot.data.toString())['datas'];
          }
          return Offstage(
            offstage: banners.length == 0,
            child: SizedBox(
              height: 135,
              child: Swiper(
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(banners[index]['imageUrl']),
                          fit: BoxFit.cover
                        )
                      )
                    )
                  );
                },
                itemCount: banners.length
              )
            ),
          );
        } else {
          return Column(
            children: [
              CircularProgressIndicator()
            ],
          );;
        }
      },
    );
  }

  buildFuctionEntries() {
    final functions = [{
      'icon': 'assets/images/studyplan.png',
      'title': '学习计划'
    }, {
      'icon': 'assets/images/exam.png',
      'title': '考试'
    }, {
      'icon': 'assets/images/exercise.png',
      'title': '题库练习'
    }, {
      'icon': 'assets/images/questionnaire.png',
      'title': '问卷调查'
    }];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: functions.map((function) {
        return Column(
          children: [
            Image.asset(function['icon'], width: 52,),
            Text(function['title'], style: TextStyle(fontSize: 12,color: Color.fromRGBO(51, 51, 51, 1)),),
          ],
        );
      }).toList(),
    );
  }

  buildTodos() {
    return Offstage(
      offstage: todo.list.length == 0, 
      child: Column(
        children: [
          // SizedBox(height: 20),
          // Container(
          //   alignment: Alignment.centerLeft,
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   height: 24,
          //   child: Text('待办事项', style: TextStyle(
          //     fontWeight: FontWeight.w700,
          //     fontSize: 17
          //   ))
          // ),
          // SizedBox(
          //   height: 10
          // ),
          ...getModuleTitle('待办事项'),
          Container(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: todo.list.length,
              itemBuilder: (context, index) {
                var item = todo.list[index];
                return Container(
                  width: 300,
                  height: 130,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.only(left: 15, right: index == todo.list.length - 1 ? 15 : 0),
                  child: Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      // border: Border.all(width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .1),
                          offset: Offset(0,0),
                          blurRadius: 8,
                          spreadRadius: 1
                        ),
                      ]
                    ),
                    child: Stack(
                      overflow: Overflow.clip,
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 110,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                              image: DecorationImage(
                                image: NetworkImage(todo.list[index]['logoUrl']),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        Positioned(
                          right: 110,
                          top: 0,
                          child: Container(
                            width: 28,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            transform: Matrix4.skewX(pi*11/180),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 190,
                            height: 120,
                            padding: EdgeInsets.only(left: 15),
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 18),
                                item['type'] == 1 ? Row(
                                  children: [
                                    Container(
                                      child: Text('考试', style: TextStyle(
                                        color: Color(0xff49af4a),
                                        fontSize: 12
                                      )),
                                      color: Color.fromRGBO(73, 175, 74, 0.1),
                                      padding: EdgeInsets.only(left: 3, right: 3),
                                    ),
                                    SizedBox(width: 6),
                                    Text(dateFormat(item['endTime'], 'MM-dd HH:mm') + '  到期', style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 12,
                                    ))
                                  ],
                                ) : Row(
                                  children: [
                                    Container(
                                      child: Text('学习计划', style: TextStyle(
                                        color: Color(0xff0099ff),
                                        fontSize: 12
                                      )),
                                      color: Color.fromRGBO(0, 153, 255, 0.1),
                                      padding: EdgeInsets.only(left: 3, right: 3),
                                    ),
                                    SizedBox(width: 6),
                                    Text(dateFormat(item['endTime'], 'yyyy-MM-dd') + '  到期', style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 12,
                                    ))
                                  ],
                                ),
                                SizedBox(height: 12),
                                Container(
                                  height: 40,
                                  alignment: Alignment.topLeft,
                                  child: Text(item['name'], overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 14,
                                  )),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 120,
                                    height: 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(2)),
                                      child: LinearProgressIndicator(
                                        value: item['process'] / 100,
                                        backgroundColor: Color(0xffe2e2e2),
                                        valueColor: AlwaysStoppedAnimation(Color(0xff3c8cfa))
                                      ),
                                    )
                                  )
                                ),
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                );
              }
            ),
          )
        ]
      )
    );
  }
  getTodoList () {
    todo.pageIndex++;
    var query = pagination(todo.pageIndex, todo.pageSize);
    getTodos(query).then((res) {
      var data = jsonDecode(res.toString());
      todo.list.addAll(data['datas']);
      setState(() {});
      todo.pages = data['paging']['pages'];
      todo.count = data['paging']['count'];
    });
  }

  buidRecommend() {
    return Offstage(
      offstage: recommend.list.length == 0,
      child: Column(
        children: [
          ...getModuleTitle('推荐课程'),
          Container(
            child: Column(
              children: recommend.list.asMap().keys.map((index) {
                var item = recommend.list[index];
                return Container(
                  height: 54,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  margin: EdgeInsets.only(top: index == 0 ? 0 : 12, bottom: index == recommend.list.length - 1 ? 16 : 0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          width: 75,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(item['imageUrl']),
                              fit: BoxFit.cover
                            )
                          )
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(item['title'], maxLines: 2, overflow: TextOverflow.ellipsis,)
                        ),
                      )
                    ],
                  )
                );
              }).toList(),
            ),
          )
        ]
      )
    );
  }
  getRecommend () {
    getBanners(query: {'type': 2}).then((res) {
      var data = jsonDecode(res.toString());
      recommend.list.addAll(data['datas']);
      setState(() {});
    });
  }

  Widget buildHonor() {
    var now = DateTime.now();
    var yesterday = dateFormat(DateTime(now.year, now.month, now.day - 1).toString(), 'yyyy-MM-dd') ;
    var query = {
      'startDate': yesterday + ' 00:00:00',
      'endDate': yesterday + ' 23:59:59'
    };
    return FutureBuilder(
      future: getStudyHonor(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var honorInfo = jsonDecode(snapshot.data.toString());
          return Offstage(
            offstage: snapshot.hasError || honorInfo == null,
            child: Column(
              children: [
                ...getModuleTitle('荣誉榜'),
                Container(
                  height: 125,
                  padding: EdgeInsets.only(left: 13, right: 13, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                            gradient: LinearGradient(colors: [Color.fromRGBO(232, 237, 244, 1), Color.fromRGBO(245, 247, 250, 1)], transform: GradientRotation(pi/4))
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.emoji_events_outlined, size: 14),
                                  SizedBox(width: 2),
                                  Text('学霸', style: TextStyle(fontSize: 12),)
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(22)),
                                      image: DecorationImage(
                                        image: NetworkImage(honorInfo['topUserStudyHours'] == 0 ? Global.userInfo.imageUrl : honorInfo['topUserImageUrl']),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(honorInfo['topUserStudyHours'] == 0 ? Global.userInfo.fullName : honorInfo['topUserName'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff333333)),),
                                        Text('昨日学时：${honorInfo['topUserStudyHours']}', style: TextStyle(fontSize: 12, color: Color(0xff333333))),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 1,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                            gradient: LinearGradient(colors: [Color.fromRGBO(232, 244, 244, 1), Color.fromRGBO(243, 248, 249, 1)], transform: GradientRotation(pi/4))
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.emoji_events_outlined, size: 14),
                                  SizedBox(width: 2),
                                  Text('金牌团队', style: TextStyle(fontSize: 12),)
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(22)),
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/honor_team.png'),
                                        // fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(honorInfo['topDeptName'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff333333)),),
                                        Text('昨日学时：${honorInfo['topDeptStudyHours']}', style: TextStyle(fontSize: 12, color: Color(0xff333333))),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return  Column(
            children: [
              CircularProgressIndicator()
            ],
          );;
        }
      },
    );
  }
  Widget buildMonthPointRank() {
    var now = DateTime.now();
    var firstDay = dateFormat(now.toString(), 'yyyy-MM') + '-01';
    var today = dateFormat(now.toString(), 'yyyy-MM-dd') ;
    var query = pagination(1, 3);
    query['startTime'] = firstDay + ' 00:00:00';
    query['endTime'] = today + ' 23:59:59';
    return FutureBuilder(
      future: getHourRank(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List list = jsonDecode(snapshot.data.toString())['datas'];
          return Offstage(
            offstage: snapshot.hasError || list.length == 0,
            child: Column(
              children: [
                ...getModuleTitle('本月学分排行'),
                Container(
                  height: 130,
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Row(
                    children: list.asMap().keys.map((index) {
                      var item = list[index];
                      return Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: index == 1 ? 2 : 0, right: index == 1 ? 2 : 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(index == 0 ? 8 : 0),
                              topRight: Radius.circular(index == 2 ? 8 : 0),
                              bottomLeft: Radius.circular(index == 0 ? 8 : 0),
                              bottomRight: Radius.circular(index == 2 ? 8 : 0)
                            ),
                            gradient: index == 0 ? LinearGradient(colors: [Color.fromRGBO(255, 197, 71, 1), Color.fromRGBO(255, 234, 150, 1)], transform: GradientRotation(pi/4))
                              : index == 1 ? LinearGradient(colors: [Color.fromRGBO(176, 202, 217, 1), Color.fromRGBO(230, 237, 242, 1)], transform: GradientRotation(pi/4))
                              : LinearGradient(colors: [Color.fromRGBO(242, 190, 122, 1), Color.fromRGBO(244, 223, 197, 1)])
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                top: 5,
                                child: Text((index + 1).toString(), style: TextStyle(
                                  fontSize: 80,
                                  fontStyle: FontStyle.italic,
                                  color: Color(index == 0 ? 0xffffd260 : index == 1 ? 0xffc6d8e3 : 0xfff3cb98)
                                )),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    padding: EdgeInsets.only(left: 14, right: 14),
                                    height: 60,
                                    // alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            image: DecorationImage(
                                              image: NetworkImage(item['imageUrl']),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 36,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(item['fullName'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff333333))),
                                                Text(item['departmentName'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Color(0xff333333))),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 36,
                                    child: Text(item['points'].toStringAsFixed(0), style: TextStyle(fontSize: 24, color: Color(index == 0 ? 0xffca8d0a : index == 1 ? 0xff7c8c94 : 0xffc98936))),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()
                  ),
                ),
              ],
            ),
          );
        } else {
          return  Column(
            children: [
              CircularProgressIndicator()
            ],
          );;
        }
      },
    );
  }
  Widget buildTotalHourRank() {
    return FutureBuilder(
      future: getPointRank({ 'limit': 10 }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List list = jsonDecode(snapshot.data.toString())['datas'];
          list = list.take(6).toList();
          var width = (MediaQuery.of(context).size.width - 30) / 2;

          return Offstage(
            offstage: snapshot.hasError || list.length == 0,
            child: Column(
              children: [
                ...getModuleTitle('总学时排行'),
                Container(
                  height: 136,
                  padding: EdgeInsets.only(top: 8),
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(colors: [Color.fromRGBO(245, 248, 250, 1), Color.fromRGBO(246, 248, 251, 1)], transform: GradientRotation(5*pi/4))
                  ),
                  child: Wrap(
                    children: list.asMap().keys.map((index) {
                      var item = list[index];
                      return Container(
                        padding: EdgeInsets.only(left: 12, top: 10, right: 12),
                        width: width,
                        // height: 38,
                        child: Row(
                          children: [
                            Text((index + 1).toString(), style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                            SizedBox(width: 12),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(14)),
                                image: DecorationImage(
                                  image: NetworkImage(item['imageUrl']),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 1,
                              child: Text(item['fullName'], overflow: TextOverflow.ellipsis)
                            )
                          ],
                        )
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return  Column(
            children: [
              CircularProgressIndicator()
            ],
          );;
        }
      },
    );
  }
}
getModuleTitle(title) {
  return [
    Container(height: 20,),
    ModuleTitle(title: title),
    SizedBox(
      height: 10
    ),
  ];
}
class ModuleTitle extends StatelessWidget {
  final String title;
  const ModuleTitle({
    Key key,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15, right: 15),
      height: 24,
      child: Text(this.title, style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 17
      ))
    );
  }
}