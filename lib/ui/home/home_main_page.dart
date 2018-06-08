import 'package:flutter/material.dart';
import 'package:gedu_bilibli/ui/home/recommend_page.dart';

class HomeMainPage extends StatelessWidget {
  static const List<String> titles = <String>["推荐", "追番", "关注"];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
          indicatorPadding: new EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
          isScrollable: false,
          tabs: titles.map((String title) {
            return new Tab(
              text: title,
            );
          }).toList(),
        ),
        body: new TabBarView(
          children: <Widget>[
            RecommendListPage(),
            RecommendListPage(),
            new CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: const Text('Demo'),
                  ),
                ),
                new SliverGrid(
                  gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0,
                  ),
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return new Container(
                        alignment: Alignment.center,
                        color: Colors.teal[100 * (index % 9)],
                        child: new Text('grid item $index'),
                      );
                    },
                    childCount: 20,
                  ),
                ),
                new SliverFixedExtentList(
                  itemExtent: 350.0,
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return new Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: new Text('list item $index'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
