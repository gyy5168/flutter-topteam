import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:topteam/common/global.dart';
import 'package:topteam/common/request.dart';

import 'package:topteam/providers/user_info.dart';
import 'package:topteam/services/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountEditControler = TextEditingController();
  TextEditingController _pwdEditControler = TextEditingController();

  Dio dio = new Dio();

  List _orgs = [];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _accountEditControler,
                decoration: InputDecoration.collapsed(hintText: '手机号18761614746'),
                cursorColor: Color.fromRGBO(102, 102, 102, 1),
              ),
              // height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(156, 156, 156, 1), width: 2),
                borderRadius: BorderRadius.circular(5)
              ),
            ),
            new SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _pwdEditControler,
                decoration: InputDecoration.collapsed(hintText: '密码123456'),
                cursorColor: Color.fromRGBO(102, 102, 102, 1),
                obscureText: true,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(156, 156, 156, 1), width: 2),
                borderRadius: BorderRadius.circular(5)
              ),
            ),
            new SizedBox(height: 20),
            FlatButton(
              color: Color.fromRGBO(60, 140, 250, 1),
              minWidth: double.infinity,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text('确定'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: _login,
            ),
            _orgs.length > 0 ? Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text(_orgs[index]['orgName']),
                      onTap: () {
                        _selectOrg(_orgs[index]);
                      },
                    )
                  );
                },
                itemCount: _orgs.length,
              ),
            ) : Container(
              width: 0,
              height: 0,
            )
          ],
        )
      ),
    );
  }

  Future<void> _login() async {
    
    // Response response = await dio.post(
    //   'https://api-ding.yunxuetang.com.cn/v1/global/tokens',
    //   data: {
    //     'userName': _accountEditControler.text != '' ? _accountEditControler.text : '18761614746',
    //     'password': _pwdEditControler.text != '' ? _pwdEditControler.text : '123456'
    //   },
    //   options: Options(
    //     headers: {
    //       'source': 1605,
    //     }
    //   )
    // );
    Response response = await accountLogin(
      {
        'userName': _accountEditControler.text != '' ? _accountEditControler.text : '18761614746',
        'password': _pwdEditControler.text != '' ? _pwdEditControler.text : '123456'
      },
    );

    
    Map<String, dynamic> res = jsonDecode(response.toString());
    if (res['error'] == null) {
      setState(() {
        _orgs = res['datas'];
      });
    } 
  }

  void _selectOrg(Map<String, dynamic> orgUser) {
    _setUserInfo(orgUser);
    Global.setUserInfo(orgUser);
    getOrgInfo().then((org) {
      Global.setOrgInfo(org.data);
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  void _setUserInfo(Map<String, dynamic> orgUser) {
    Provider.of<UserInfo>(context, listen: false).setUserInfo(orgUser);
    Request().setToken(orgUser['token']);
  }
}