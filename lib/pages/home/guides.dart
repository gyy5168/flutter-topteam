import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeGuides extends StatefulWidget {
  HomeGuides({Key key}) : super(key: key);

  @override
  _HomeGuidesState createState() => _HomeGuidesState();
}

class _HomeGuidesState extends State<HomeGuides> {
  bool _guidesVisible = false;
  @override
  void initState() {
    super.initState();
    getGuideSet();
  }
  Future getGuideSet() async {
    var hideGuides;
    SharedPreferences perfs = await SharedPreferences.getInstance();
    hideGuides = perfs.getBool('hideGuides')??false;
    // await perfs.remove('hideGuides');
    setState(() {
      _guidesVisible = !hideGuides;
    });
  }
  @override
  Widget build(BuildContext context) {
    return buildGuides();
  }
   buildGuides() {
    final guides = [
      {
        'color': LinearGradient(colors: [Color.fromRGBO(0, 186, 171, 1), Color.fromRGBO(12, 216, 200, 1)], transform: GradientRotation(pi/3)),
        'text': '上线通知开启移动学习',
        'title': '上线通知',
        'shadowColor': Color.fromRGBO(16, 149, 138, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(29, 163, 207, 1), Color.fromRGBO(84, 204, 243, 1)], transform: GradientRotation(pi/3)),
        'text': '新员工培训简单三步自动配',
        'title': '新员工培训',
        'shadowColor': Color.fromRGBO(7, 134, 179, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(113, 141, 213, 1), Color.fromRGBO(140, 158, 253, 1)], transform: GradientRotation(pi/3)),
        'text': '考前巩固刷题模式练一练',
        'title': '题库练习模式',
        'shadowColor': Color.fromRGBO(75, 97, 167, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(183, 117, 208, 1), Color.fromRGBO(140, 125, 232, 1)], transform: GradientRotation(pi/3)),
        'text': '学考一体实时跟踪',
        'title': '学习计划2.0',
        'shadowColor': Color.fromRGBO(75, 97, 167, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(222, 105, 155, 1), Color.fromRGBO(226, 92, 221, 1)], transform: GradientRotation(pi/3)),
        'text': '线上搭建企业课程体系',
        'title': '设置课程目录',
        'shadowColor': Color.fromRGBO(166, 75, 171, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(245, 86, 86, 1), Color.fromRGBO(248, 117, 148, 1)], transform: GradientRotation(pi/3)),
        'text': '多类型课件创作与管理',
        'title': '丰富企业课程',
        'shadowColor': Color.fromRGBO(199, 79, 96, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(255, 130, 117, 1), Color.fromRGBO(241, 139, 89, 1)], transform: GradientRotation(pi/3)),
        'text': '在线考试检验学习效果',
        'title': '如何安排考试',
        'shadowColor': Color.fromRGBO(211, 77, 93, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(135, 191, 0, 1), Color.fromRGBO(178, 216, 27, 1)], transform: GradientRotation(pi/3)),
        'text': '分级权限灵活管理',
        'title': '配置管理权限',
        'shadowColor': Color.fromRGBO(102, 137, 0, .3)
      },
      {
        'color': LinearGradient(colors: [Color.fromRGBO(255, 163, 95, 1), Color.fromRGBO(246, 199, 36, 1)], transform: GradientRotation(pi/3)),
        'text': '有效运用学分激励',
        'title': '了解学分管理',
        'shadowColor': Color.fromRGBO(208, 104, 0, .3)
      }
    ];
    return Offstage(
      offstage: !_guidesVisible,
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            height: 24,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('快速使用指南', style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17
                  ))
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Color(0xff666666),
                      size: 18
                    ),
                    onTap: hideGuides
                  )
                )
              ],
            )
          ),
          SizedBox(
            height: 10.h
          ),
          Container(
            height: 54.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              children: guides.asMap().keys.map((index){
                return Container(
                  width: 90.w,
                  height: 54.h,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 7.w),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 7.w,
                        bottom: 0,
                        child: Container(
                          width: 76.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: guides[index]['shadowColor'],
                            borderRadius: BorderRadius.all(Radius.circular(4.r)),
                          ),
                        ) 
                      ),
                      Container(
                        width: 90.w,
                        height: 52.h,
                        alignment: Alignment(0, 0),
                        padding: EdgeInsets.only(left: 6.w, right: 6.w),
                        child: Text(guides[index]['text'], style: TextStyle(color: Color.fromRGBO(250, 250, 250, 1), fontSize: 12.ssp),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.r)),
                          color: Color.fromRGBO(0, 186, 171, 1),
                          gradient: guides[index]['color'],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          )
        ],
      )
    ); 
  }
  void hideGuides() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    setState(() {
      _guidesVisible = false;
    });
    perfs.setBool('hideGuides', true);
  }
}