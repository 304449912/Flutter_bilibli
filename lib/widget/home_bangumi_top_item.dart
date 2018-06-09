import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BangUmiTopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return new Container(
      padding: new EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new RaisedButton(
            onPressed: () {},
            color: Colors.yellow[800],
            padding: new EdgeInsets.all(5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: new Image.asset("images/ic_following_bangumi.png",
                      matchTextDirection: true, width: 35.0, height: 35.0),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: new Text(
                    "追番",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          new RaisedButton(
            onPressed: () {},
            color: Colors.yellow[800],
            padding: new EdgeInsets.all(5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: new Image.asset("images/ic_bangumi_calendar_7.png",
                      matchTextDirection: true, width: 35.0, height: 35.0),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(15.0, 0.0, 10.5, 0.0),
                  child: new Text(
                    "送放",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          new RaisedButton(
            onPressed: () {},
            color: Colors.yellow[800],
            padding: new EdgeInsets.all(5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: new Image.asset("images/ic_bangumi_category.png",
                      matchTextDirection: true, width: 35.0, height: 35.0),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: new Text(
                    "索引",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}