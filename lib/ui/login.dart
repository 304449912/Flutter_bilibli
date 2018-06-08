import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gedu_bilibli/ui/home_page.dart';

import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String password;
  String username;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
      ),
      body: new Container(
        child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Image(
                        image: new AssetImage("images/ic_22.png"),
                        fit: BoxFit.cover,
                        height: 80.0,
                      ),
                      new Image(
                        image: new AssetImage("images/ic_bili_logo_2016.png"),
                        fit: BoxFit.cover,
                        height: 60.0,
                      ),
                      new Image(
                        image: new AssetImage("images/ic_33.png"),
                        fit: BoxFit.cover,
                        height: 80.0,
                      ),
                    ],
                  ),
                  margin: new EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                ),
                new Container(
                  padding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: new TextFormField(
                    decoration: const InputDecoration(
                        hintText: '用户名',
                        hintStyle: const TextStyle(fontSize: 14.0),
                        contentPadding: EdgeInsets.all(5.0),
                        prefixIcon: ImageIcon(
                          AssetImage("images/ic_login_username_default.png"),
                          color: Colors.black,
                          size: 25.0,
                        )),
                    obscureText: true,
                    validator: userNameValidator,
                    initialValue: '',
                    maxLines: 1,
                    onSaved: (String value) {
                      username = value;
                      print(value);
                    },

                  ),
                ),
                new Container(
                  padding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: new TextFormField(
                    decoration: const InputDecoration(
                        hintText: '由数字 - _ 组成的密码',
                        hintStyle: const TextStyle(fontSize: 14.0),
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: ImageIcon(
                          AssetImage("images/ic_login_password_default.png"),
                          color: Colors.black,
                          size: 25.0,
                        )),
                    obscureText: true,
                    validator: passwordValidator,
                    initialValue: '',
                    maxLines: 1,
                    onSaved: (String value) {
                      password = value;
                      print(value);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                  child: new CupertinoButton(
                    child: const Text('登录'),
                    color: CupertinoColors.activeBlue,
                    pressedOpacity: 0.8,
                    padding: new EdgeInsets.fromLTRB(165.0, 10.0, 165.0, 10.0),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(400.0)),
                    onPressed: login,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String userNameValidator(String username) {
    if (username.trim().length == 0) return "请输入用户名";
    return null;
  }

  String passwordValidator(String pass) {
    if (pass.trim().length == 0) return "请输入密码";
    return null;
  }

  Future login() async {
//    username:304449912@qq.com
//    password:wlq304449912
    if (_formKey.currentState.validate()) {
      print('login form error');
    } else {
      username = '304449912@qq.com';
      password = 'wlq304449912';
      print("username $username , password: $password");
      var response = await http.post("http://www.wanandroid.com/user/login",
          body: {'username': this.username, 'password': this.password},
          encoding: Encoding.getByName("utf-8"));
      print(response.body);
      print(response.headers);
      if (response.statusCode == HttpStatus.OK) {
        Map data = json.decode(response.body);
        if (data['errorCode'] != 0) {
          String msg = data['errorMsg'];
          String errMsg = msg == null || msg.trim().isEmpty ? "登陆失败" : msg;
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("loginCookie", json.encode(data['data']));
          String setCookie = response.headers['set-cookie'];
          prefs.setString("set-cookie", setCookie);
//          Navigator.of(this.context).pop("login");
          Navigator.of(context).pushNamed("/homepage");
        }
      } else {}
    }
  }
}
