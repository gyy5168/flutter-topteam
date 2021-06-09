import 'package:flutter/material.dart';
import 'package:topteam/pages/home.dart';
import 'package:topteam/pages/kng.dart';
import 'package:topteam/pages/course.dart';
import 'package:topteam/pages/my.dart';

class NavItem {
  const NavItem({ this.label, this.icon });
  final String label;
  final IconData icon;
}

const List<NavItem> navList = const <NavItem>[
  const NavItem(label: '首页', icon: Icons.home_outlined ),
  const NavItem(label: '企业课程', icon: Icons.school_outlined),
  const NavItem(label: '金牌课程', icon: Icons.shopping_bag_outlined),
  const NavItem(label: '我的', icon: Icons.account_circle_outlined)
];

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  List<Widget> pageWidgets;

  @override
  void initState() {
    super.initState();
    if (pageWidgets == null) {
      pageWidgets = [
        HomePage(),
        KngPage(),
        CoursePage(),
        MyPage()
      ];
    }
  }
  int _selectIndex = 0;

  Widget _getPageWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pageWidgets[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        _getPageWidget(0),
        _getPageWidget(1),
        _getPageWidget(2),
        _getPageWidget(3),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromRGBO(170, 170, 170, 1),
        unselectedFontSize: 12.0,
        selectedItemColor: Color.fromRGBO(60, 140, 250, 1),
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        items: navList.map((NavItem item) {
          return BottomNavigationBarItem(
            label: item.label,
            icon: Icon(item.icon),
          );
        }).toList(),
        currentIndex: _selectIndex,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
      ),
    );
  }
}
