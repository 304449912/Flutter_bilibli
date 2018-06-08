import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gedu_bilibli/ui/home_page.dart';
import 'package:gedu_bilibli/ui/login.dart';
import 'package:gedu_bilibli/ui/me_page.dart';
import 'package:gedu_bilibli/widget/tab_page_selector.dart';

void main() => runApp(new MyApp());

Map<String, WidgetBuilder> buildRoutes() {
  return <String, WidgetBuilder>{
    '/homepage': (BuildContext context) => new MyHomePage(),
  };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: buildRoutes(),
      home: new MyHomePage(),
    );
  }
}


