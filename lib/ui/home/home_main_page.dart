import 'package:flutter/material.dart';
import 'package:gedu_bilibli/ui/home/home_bangumi_page.dart';
import 'package:gedu_bilibli/ui/home/home_recommend_page.dart';

class HomeMainPage extends StatefulWidget {
  List<String> titles;
  final String cid;
  ScrollController controller;
  HomeMainPage(
      {@required this.cid, @required this.pageState, @required this.titles});
  Map<String, SortItemPageBean> pageState;
  @override
  State<StatefulWidget> createState() => HomeMainPageState();
}

class HomeMainPageState extends State<HomeMainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.titles.length,
        vsync: this,
        initialIndex: widget.pageState[widget.cid].currentPage);
    _tabController.addListener(() {
      widget.pageState[widget.cid].currentPage = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: widget.titles.length,
      child: new Scaffold(
        appBar: new TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
          indicatorPadding: new EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
          isScrollable: false,
          tabs: widget.titles.map((String title) {
            return new Tab(
              text: title,
            );
          }).toList(),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: widget.titles.map((title) {
            SortItemPageBean bean = widget.pageState[title];
            if (bean.page == null) {
              bean.offset = 0.0;
              if (bean.cid == widget.titles[0]) {
                bean.page = RecommendListPage(
                  cid: bean.cid,
                  pageState: widget.pageState,
                );
              } else if (bean.cid == widget.titles[1]) {
                bean.page = BangUmiListPage(
                  cid: bean.cid,
                  pageState: widget.pageState,
                );
              } else if (bean.cid == widget.titles[2]) {
                bean.page = new Text("第三页");
              }
            }
            return bean.page;
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class SortItemPageBean {
  String cid;

  ///当前TabBar page
  Widget page;

  ///当前页面滑动的位置
  double offset;

  ///主页（第一屏）保存位置和数据
  Map<int, SortItemPageBean> map;

  ///当前页面选中的位置
  int currentPage;

  SortItemPageBean({@required this.cid});
}
