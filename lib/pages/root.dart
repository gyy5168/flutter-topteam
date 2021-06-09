import 'package:flutter/material.dart';
import 'package:topteam/pages/container.dart';
import 'package:topteam/pages/login.dart';

enum LoginStatus {
  LOADING,
  LOGGED_IN,
  NOT_LOGGED_IN
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  LoginStatus loginStatus = LoginStatus.NOT_LOGGED_IN;

  @override
  Widget build(BuildContext context) {
    switch (loginStatus) {
      case LoginStatus.LOADING:
        return buildLoading();
        break;
      case LoginStatus.NOT_LOGGED_IN:
        return LoginPage();
        break;
      case LoginStatus.LOGGED_IN:
        return ContainerPage();
        break;
      default:
        return buildLoading();
    }
  }

  Widget buildLoading() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}