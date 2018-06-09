import 'package:flutter/material.dart';
import 'package:gedu_bilibli/ui/home/home_bangumi_page.dart';
import 'package:gedu_bilibli/ui/home/home_recommend_page.dart';

class HomeMainPage extends StatefulWidget {

  List<String> titles = <String>["推荐", "追番", "关注"];
  final String cid;
  ScrollController controller;
  int currentPage;

  HomeMainPage({@required this.cid, @required this.currentPage});

  @override
  State<StatefulWidget> createState() => HomeMainPageState();

}

class HomeMainPageState extends State<HomeMainPage>
    with SingleTickerProviderStateMixin {
  List<SortItemPageBean> sortItemPageBean = <SortItemPageBean>[];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: widget.titles.length, vsync: this,initialIndex: widget.currentPage);
    _tabController.addListener((){
      widget.currentPage=_tabController.index;
      print("-----------${_tabController.index}");
    });
    widget.titles.map((name) {
      print('_TreeItemTabsPageState $name');
      sortItemPageBean.add(new SortItemPageBean(cid: name));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
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
          children: sortItemPageBean.map((bean) {
            if (bean.page == null) {
              bean.offset = 0.0;
              if (bean.cid == widget.titles[0]) {
                print(bean.offset);
                bean.page = RecommendListPage(
                  cid: bean.cid,
                  offset: bean.offset,
                );
              } else if (bean.cid == widget.titles[1]) {
                bean.page = BangUmiListPage(
                  cid: bean.cid,
                  offset: bean.offset,
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

  ///当前页面选中的位置
  int currentPage;

  SortItemPageBean({@required this.cid});
}
