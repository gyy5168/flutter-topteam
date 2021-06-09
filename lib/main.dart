import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topteam/common/global.dart';

import 'package:topteam/pages/container.dart';
import 'package:topteam/pages/home.dart';
import 'package:topteam/pages/kng.dart';
import 'package:topteam/pages/course.dart';
import 'package:topteam/pages/my.dart';
import 'package:topteam/pages/login.dart';
import 'package:topteam/pages/root.dart';

import 'package:topteam/providers/user_info.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
class TopteamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 667),
      allowFontScaling: false,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        // home: RootPage(),
        initialRoute: '/login',
        navigatorKey: AppRouter.navigatorKey,
        routes: <String, WidgetBuilder>{
          // '/': (BuildContext context) {
          //   return ContainerPage();
          // },
          '/home': (BuildContext context) {
            return ContainerPage();
          },
          '/kng': (BuildContext context) {
            return KngPage();
          },
          '/course': (BuildContext context) {
            return CoursePage();
          },
          '/my': (BuildContext context) {
            return MyPage();
          },
          '/login': (BuildContext context) {
            return LoginPage();
          },
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('zh', 'CN')
        ],
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((res){
    runApp(
      ChangeNotifierProvider(
        create: (context) => UserInfo(),
        child: TopteamApp(),
      )
    );
    if (Platform.isAndroid) {
      //设置Android头部的导航栏透明
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}
