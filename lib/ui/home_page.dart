import 'package:flutter/material.dart';
import 'package:gedu_bilibli/ui/home/home_main_page.dart';
import 'package:gedu_bilibli/ui/me_page.dart';
import 'package:gedu_bilibli/ui/meizi/prcture_meizi.dart';
import 'package:gedu_bilibli/utils/navigator.dart';
import 'package:gedu_bilibli/widget/tab_page_selector.dart';

const List<Choice> choices = const <Choice>[
  const Choice(title: '主页', icon: Icons.home),
  const Choice(title: '分区', icon: Icons.cloud),
  const Choice(title: '知识体系', icon: Icons.memory),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("app state $state");
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = <Widget>[];
    listWidget.add(new Center(
      child: new HomeMainPage(),
    ));
    listWidget.add(new Center(
      child: new Text("分区"),
    ));
    listWidget.add(new MePage());
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("bilibili"),
        leading: new Center(
          child: new GestureDetector(
            child: new CircleAvatar(
              backgroundImage: new NetworkImage(
                  "https://b-ssl.duitang.com/uploads/item/201508/02/20150802102918_UZYdH.thumb.700_0.jpeg"),
              radius: 15.0,
              backgroundColor: Colors.transparent,
            ),
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        centerTitle: true,
        titleSpacing: 10.0,
        automaticallyImplyLeading: true,

        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.file_download),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.gavel),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  margin: new EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color(0xffF5F7FA),
                    const Color(0xffF5F7FA),
                  ])),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(
                          "https://b-ssl.duitang.com/uploads/item/201508/02/20150802102918_UZYdH.thumb.700_0.jpeg"),
                      radius: 32.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                )),
            ListTile(
              title: Text("福利"),
              trailing: Icon(Icons.face),
              onTap: () {
                goToMeizi(context);
              },
            ),
            ListTile(
              title: Text("Favorites"),
              trailing: Icon(Icons.favorite),
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Movies"),
              trailing: Icon(Icons.local_movies),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("TV Shows"),
              trailing: Icon(Icons.live_tv),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: new TabBarView(
        children: listWidget,
        controller: _tabController,
//          physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: new BottomTabPageSelector(
        controller: _tabController,
        choices: choices,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
  }

}
