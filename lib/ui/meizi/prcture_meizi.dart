import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gedu_bilibli/model/girl_model.dart';
import 'package:gedu_bilibli/net/http_provider.dart';
import 'package:gedu_bilibli/utils/navigator.dart';
import 'package:gedu_bilibli/widget/ProgreessDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gedu_bilibli/widget/cached_network_image.dart';
class MeiZiListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _MeiZiListListState();
}

class _MeiZiListListState extends State<MeiZiListPage> {
  ScrollController _scrollController;

  List<GirlModel> _girlList = List();
  GankProvider gankProvider;

  var _refreshIndicatorKey;

  int curPageNum = 1;

  bool isSlideUp = false;

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      setState(() {
        _loadData();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gankProvider = new GankProvider();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var content;
    _girlList.map((GirlModel g) =>print(g.url)).toList();

    if (_girlList.isEmpty) {
      content = getProgressDialog();
    } else {
      content = GridView.count(
        controller: _scrollController,
        padding: new EdgeInsets.all(10.0),
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        scrollDirection: Axis.vertical,
        childAspectRatio: 0.78,
        children: _girlList
            .map((GirlModel girl) => Card(
                  elevation: 2.0,
                  child: InkWell(
                    onTap: () => goToMeiZiDetail(context, _girlList,girl),
                    child: IntrinsicHeight(
                      child: new CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 300),
                        fadeOutDuration: Duration(milliseconds: 100),
                        imageUrl: girl.url,
                        fit: BoxFit.cover,
                        width: double.infinity,

                      ),
                    ),
                  ),
                ))
            .toList(),
      );
    }
    var _refreshIndicator = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: content,
    );
    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("福利"),
        ),
        body: _refreshIndicator,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  Future<Null> _refreshData() async {
    isSlideUp = false;
    final Completer<Null> completer = new Completer<Null>();
    curPageNum = 1;
    var girls = await gankProvider.loadMedia(10, curPageNum);
    setState(() {
      _girlList.addAll(girls);
    });

    completer.complete(null);

    return completer.future;
  }

  Future<Null> _loadData() async {
    isSlideUp = true;
//    Fluttertoast.showToast(
//        msg: "This is Center Short Toast",
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1
//    );
    final Completer<Null> completer = new Completer<Null>();

    curPageNum = curPageNum + 1;

    var girls = await gankProvider.loadMedia(10, curPageNum);
    setState(() {
      _girlList.addAll(girls);
    });

    completer.complete(null);

    return completer.future;
  }
}
