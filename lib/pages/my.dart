import 'package:flutter/material.dart';

import 'manage/exam/list.dart';

List entries = [{
  'type': 'my_org',
  'icon': 'my_org.png',
  'title': '我的企业',
}, {
  'type': 'service',
  'icon': 'service.png',
  'title': '专属服务',
}, {
  'type': 'task',
  'icon': 'task.png',
  'title': '会员任务',
}];
List menus = [{
  'type': 'catalog',
  'icon': 'catalog.png',
  'title': '目录管理',
}, {
  'type': 'course',
  'icon': 'course.png',
  'title': '课程管理',
}, {
  'type': 'check',
  'icon': 'check.png',
  'title': '课程审核',
}, {
  'type': 'course',
  'icon': 'course.png',
  'title': '金牌课程管理',
}, {
  'type': 'studyplan',
  'icon': 'studyplan.png',
  'title': '学习计划管理',
}, {
  'type': 'library',
  'icon': 'library.png',
  'title': '题库管理',
}, {
  'type': 'paper',
  'icon': 'paper.png',
  'title': '试卷管理',
}, {
  'type': 'exam',
  'icon': 'exam.png',
  'title': '考试管理',
}, {
  'type': 'point',
  'icon': 'point.png',
  'title': '学分规则',
}, {
  'type': 'staff_studyplan',
  'icon': 'staff_studyplan.png',
  'title': '员工参加的计划',
}, {
  'type': 'staff_exam',
  'icon': 'staff_exam.png',
  'title': '员工参加的考试',
}, {
  'type': 'depart_study',
  'icon': 'depart_study.png',
  'title': '部门学习统计',
}, {
  'type': 'staff_study',
  'icon': 'staff_study.png',
  'title': '员工学习统计',
}, {
  'type': 'period',
  'icon': 'period.png',
  'title': '周期数据统计',
}, {
  'type': 'system',
  'icon': 'system.png',
  'title': '系统设置',
}];

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/my/manage_bg.jpg'),
                  fit: BoxFit.fitWidth
                )
              ),
            ),
            ...entries.asMap().keys.map((index) {
              var item = entries[index];
              return ListItem(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xfff2f2f2), width: index == entries.length - 1 ? 0 : 1))
                ),
                leading: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/my/${item['icon']}',
                  ),
                ),
                title: Text(item['title'], style: TextStyle(
                  fontSize: 15
                ), overflow: TextOverflow.ellipsis),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xffcccccc),),
                onTap: () {
                  entryClick(context, item['type']);
                }
              );
            }).toList(),
            Container(
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                border: Border(bottom: BorderSide(color: Color(0xfff2f2f2), width: 1), top: BorderSide(color: Color(0xfff2f2f2), width: 1))
              )
            ),
            ...menus.asMap().keys.map((index) {
              var item = menus[index];
              return ListItem(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xfff2f2f2), width: index == menus.length - 1 ? 0 : 1))
                ),
                leading: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/my/${item['icon']}',
                  ),
                ),
                title: Text(item['title'], style: TextStyle(
                  fontSize: 15
                ), overflow: TextOverflow.ellipsis),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xffcccccc),),
                onTap: () {
                  entryClick(context, item['type']);
                }
              );
            }).toList(),
          ],
        )
      ),
    );
  }

  entryClick(context, item) {
    switch (item) {
      case 'exam':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExamManage()));
        break;
      default:
    }
  }
  
}


class ListItem extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final double height;
  final GestureTapCallback onTap;
  const ListItem({
    Key key,
    this.decoration,
    this.leading,
    this.title,
    this.trailing,
    this.height : 60,
    this.onTap
  }) : super(key: key);

  @override
    Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: Container(
        height: this.height,
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: this.decoration,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              this.leading,
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: title,
                ),
              ),
              this.trailing
            ],
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 15, right: 15),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border(bottom: BorderSide(color: Color(0xfff2f2f2), width: 1))
  //       ),
  //       child: ListTile(
  //         leading: Container(
  //           width: 16,
  //           alignment: Alignment.centerLeft,
  //           child: Image.asset(
  //             'assets/images/my/exam_manage.png',
  //           ),
  //         ),
  //         title: Text('考试管理'),
  //         trailing: Icon(Icons.arrow_forward_ios, size: 18,),
  //       ),
  //     ),
  //   );
  // }
}