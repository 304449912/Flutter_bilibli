import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MePageState();
}

class _MePageState extends State<MePage> {
  
  @override
  void initState() {
    // TODO: implement initState
    print("me pages init");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          child: Image.asset(
            "images/ic_login_password_default.png",
            fit: BoxFit.cover,
          ),
        ),
        new Column(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: new Center(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "https://b-ssl.duitang.com/uploads/item/201508/02/20150802102918_UZYdH.thumb.700_0.jpeg"),
                  radius: 32.0,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: new Text(
                "王先生",
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            new Text(
              "304449912@qq.com",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(60.0, 30.0, 60.0, 0.0),
              child: new Stack(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Text(
                        "100万",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        "年度绩效目标",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  new Center(
                    child: new Container(
                      margin:new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0) ,
                      width: 1.0,
                      height: 60.0,
                      decoration: new BoxDecoration(
                        border: new Border(
                          left: new BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Align(
                    alignment: Alignment.centerRight,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "30万",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500),
                        ),
                        new Text(
                          "已完成",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        )
      ],
    );
  }
}
//new Image.network("https://b-ssl.duitang.com/uploads/item/201508/02/20150802102918_UZYdH.thumb.700_0.jpeg",
//width: 64.0,
//height: 64.0,
//)
