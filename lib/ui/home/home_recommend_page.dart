import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gedu_bilibli/model/bilibli_recommend.dart';
import 'package:gedu_bilibli/model/bilibli_recommend_banner.dart';
import 'package:gedu_bilibli/net/http_provider.dart';
import 'package:banner/banner.dart';
import 'package:gedu_bilibli/ui/home/home_main_page.dart';
import 'package:gedu_bilibli/widget/cached_network_image.dart';

class RecommendListPage extends StatefulWidget {
  final String cid;
  ScrollController controller;
  List<RecommendInfo> _recommendInfos = List();
  List<RecommendBanner> _recommendBanner = List();

  bool loading = true;
  Map<String, SortItemPageBean> pageState;
  RecommendListPage({@required this.cid, @required this.pageState});

  @override
  State<StatefulWidget> createState() => RecommendListPageState();
}

class RecommendListPageState extends State<RecommendListPage> {
  BiliBliProvider biliBliProvider;
  @override
  void initState() {
    biliBliProvider = BiliBliProvider();
    if (widget.loading) {
      _loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///ScrollController是控制ListView滑动到那个位置的，设置
    double width =MediaQuery.of(context).size.width;
    widget.controller = new ScrollController(
        initialScrollOffset: widget.pageState[widget.cid].offset);
    widget.controller.addListener(() {
      ///当绑定了该ScrollController的ListView滑动时就会调用该方法
      widget.pageState[widget.cid].offset = widget.controller.offset;
    });
    List<Widget> widgets = List();
    if (widget._recommendBanner.length > 0) {
      widgets.add(SliverToBoxAdapter(
        child: new BannerView(
          height: 120.0,
          data: widget._recommendBanner,
          buildShowView: (index, data) {
            return new CachedNetworkImage(
              imageUrl: data.image,
              fit: BoxFit.cover,
            );
          },
          onBannerClickListener: (index, data) {
            print(data.image);
          },
        ),
      ));
    }
    for (int i = 0; i < widget._recommendInfos.length; i++) {
      widgets.add(new SliverToBoxAdapter(
          child: new _headView(
        headBean: widget._recommendInfos[i].head,
      )));
      widgets.add(SliverGrid.count(
        crossAxisCount: 2,
        children: widget._recommendInfos[i].body
            .map((BodyBean body) => Card(
                  margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                  elevation: 2.0,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 100),
                          imageUrl: body.cover,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: (width-50)/3,
                        ),
                        Padding(
                          child: new Text(
                            body.title == null ? "" : body.title,
                            maxLines: 2,
                          ),
                          padding:
                          EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        ),
                        new Row(
                          children: <Widget>[
                            new Offstage(
                              offstage: widget._recommendInfos[i].type ==
                                  'live',
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: new Image.asset(
                                  widget._recommendInfos[i].type == 'live'
                                      ? "images/ic_play_circle_outline_black_24dp.png"
                                      : "images/ic_play_circle_outline_black_24dp.png",
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                            ),
                            new Padding(
                              padding: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                              child: new Text(
                                  widget._recommendInfos[i].type == 'live'
                                      ? body.up
                                      : body.play == null ? "" : body.play),),
                            new Offstage(
                              offstage: widget._recommendInfos[i].type ==
                                  'live',
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: new Image.asset(
                                  widget._recommendInfos[i].type == 'live'
                                      ? "images/ic_watching.png"
                                      : "images/ic_subtitles_black_24dp.png",
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                            ),
                            new Padding(
                              padding: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                              child: new Text(
                                widget._recommendInfos[i].type == 'live'
                                    ? body.online.toString()
                                    : body.danmaku == null
                                    ? ""
                                    : body.danmaku,
                                maxLines: 1,),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ));
    }
    return new CustomScrollView(
      controller: widget.controller,
      shrinkWrap: true,
      slivers: widgets,
    );
  }

  void _loadData() async {
    var infos = await biliBliProvider.fetchRecommendInfoListModel();
    var banners = await biliBliProvider.fetchRecommendBannerListModel();
    setState(() {
      widget._recommendInfos.addAll(infos);
      widget._recommendBanner.addAll(banners);
      widget.loading = false;
    });
  }
}

class _headView extends StatelessWidget {
  final HeadBean headBean;

  const _headView({
    Key key,
    @required this.headBean,
  })  : assert(headBean != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            headBean.title,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            child: const Text('更多'),
            onTap: () {},
          ),
        ],
      ),
    );
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
