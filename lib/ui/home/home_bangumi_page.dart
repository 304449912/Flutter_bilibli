import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gedu_bilibli/model/bilibli_bangumi_banner.dart';
import 'package:gedu_bilibli/model/bilibli_bangumi_info.dart';
import 'package:gedu_bilibli/model/bilibli_recommend.dart';
import 'package:gedu_bilibli/net/http_provider.dart';
import 'package:banner/banner.dart';
import 'package:gedu_bilibli/ui/home/home_main_page.dart';
import 'package:gedu_bilibli/utils/string_utils.dart';
import 'package:gedu_bilibli/widget/cached_network_image.dart';
import 'package:gedu_bilibli/widget/home_bangumi_top_item.dart';

class BangUmiListPage extends StatefulWidget {
  final String cid;
  ScrollController controller;
  List<BangUmiBean> _serializing = List();
  Previous _previous;
  List<BangUmiHead> _recommendBanner = List();
  List<BangUmiInfo> _bangUmiInfoList = List();
  Map<String ,SortItemPageBean > pageState;
  BangUmiListPage({@required this.cid,@required this.pageState});

  @override
  State<StatefulWidget> createState() => BangUmiListPageState();
}

class BangUmiListPageState extends State<BangUmiListPage> {
  BiliBliProvider biliBliProvider;

  @override
  void initState() {
    biliBliProvider = BiliBliProvider();
    if(widget._bangUmiInfoList.length==0&&widget._bangUmiInfoList.length==0){
      _loadData();
      _loadBangUmiInfoList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///ScrollController是控制ListView滑动到那个位置的，设置
    widget.controller = new ScrollController(initialScrollOffset: widget.pageState[widget.cid].offset);
    widget.controller.addListener(() {
      ///当绑定了该ScrollController的ListView滑动时就会调用该方法
      widget.pageState[widget.cid].offset = widget.controller.offset;
    });
    List<Widget> widgets = List();
    //添加banner
    if (widget._recommendBanner.length > 0) {
      widgets.add(SliverToBoxAdapter(
        child: new BannerView(
          height: 120.0,
          data: widget._recommendBanner,
          buildShowView: (index, data) {
            return new CachedNetworkImage(
              imageUrl:data.img,
              fit: BoxFit.cover,
            );
          },
          onBannerClickListener: (index, data) {
            print(index);
          },
        ),
      ));
      //追番。放送表 索引图片
      widgets.add(SliverToBoxAdapter(child: BangUmiTopItem()));
    }
    //新番连载
    widgets.add(new SliverToBoxAdapter(
        child: Container(
      padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '新番连载 ',
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            child: const Text('所有连载'),
            onTap: () {},
          ),
        ],
      ),
    )));
    widgets.add(SliverGrid.count(
      childAspectRatio: 0.603,
      crossAxisCount: 3,
      children: widget._serializing
          .map((BangUmiBean bangUmi) => new SizedBox(
                height: 200.0,
                child: Card(
                  margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                  elevation: 0.0,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            new CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 300),
                              fadeOutDuration: Duration(milliseconds: 100),
                              imageUrl:bangUmi.cover,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 160.0

                            ),
                            Padding(
                              padding:
                                  new EdgeInsets.fromLTRB(5.0, 140.0, 0.0, 0.0),
                              child: new Text(
                                '${bangUmi.watchingCount}人在看',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                        new Container(
                          height: 50.0,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                child: new Text(
                                  bangUmi.title == null ? "" : bangUmi.title,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              ),
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: new Text(
                                  '更新到${bangUmi.newestEpIndex}话',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    ));

    //新番连载
    if (widget._previous != null) {
      widgets.add(new SliverToBoxAdapter(
          child: Container(
        padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${widget._previous.season}月新番',
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              child: const Text('分季列表'),
              onTap: () {},
            ),
          ],
        ),
      )));
      widgets.add(SliverGrid.count(
        childAspectRatio: 0.663,
        crossAxisCount: 3,
        children: widget._previous.list
            .map((BangUmiBean bangUmi) => new SizedBox(
                  height: 200.0,
                  child: Card(
                    margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                    elevation: 0.0,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Stack(
                            children: <Widget>[
                              new CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 300),
                                fadeOutDuration: Duration(milliseconds: 100),
                                imageUrl: bangUmi.cover,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 160.0,
                              ),
                              Padding(
                                padding: new EdgeInsets.fromLTRB(
                                    5.0, 140.0, 0.0, 0.0),
                                child: new Text(
                                  '${converString(bangUmi.favourites)}人在追番',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              Padding(
                                child: new Text(
                                  bangUmi.title == null ? "" : bangUmi.title,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ));

      if (widget._bangUmiInfoList.length > 0) {
        widgets.add(new SliverToBoxAdapter(
            child: Container(
          padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '番剧推荐',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )));
        widgets.add(
          new SliverFixedExtentList(
            itemExtent: 230.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Card(
                margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                elevation: 0.0,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          new CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 300),
                            fadeOutDuration: Duration(milliseconds: 100),
                            imageUrl: widget._bangUmiInfoList[index].cover,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 160.0,
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          Padding(
                            child: new Text(
                              widget._bangUmiInfoList[index].title == null
                                  ? ""
                                  : widget._bangUmiInfoList[index].title,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          Padding(
                            child: new Text(
                              widget._bangUmiInfoList[index].desc == null
                                  ? ""
                                  : widget._bangUmiInfoList[index].desc,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: new TextStyle(color: Colors.grey),
                            ),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }, childCount: widget._bangUmiInfoList.length),
          ),
        );
      }
    }

    return new CustomScrollView(
      controller: widget.controller,
      shrinkWrap: true,
      slivers: widgets,
    );
  }

  void _loadData() async {
    var bangUmiRecommend = await biliBliProvider.fetchBangUmiRecommendModel();
    setState(() {
      widget._serializing.addAll(bangUmiRecommend.serializing);
      widget._recommendBanner.addAll(bangUmiRecommend.head);
      widget._previous = bangUmiRecommend.previous;
    });
  }

  void _loadBangUmiInfoList() async {
    var bangUmiInfoList = await biliBliProvider.fetchBangUmiInfoListModel();
    setState(() {
      widget._bangUmiInfoList.addAll(bangUmiInfoList);
    });
  }
}

class RecommendInfoItem extends StatefulWidget {
  final List<BodyBean> bodyBeanList;

  const RecommendInfoItem({
    Key key,
    @required this.bodyBeanList,
  })  : assert(bodyBeanList != null),
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new RecommendInfoItemState();
  }
}

class RecommendInfoItemState extends State<RecommendInfoItem> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: widget.bodyBeanList.map((BodyBean body) {
        return new Text(body.title);
      }).toList(),
    );
  }
}
