import 'package:gedu_bilibli/model/girl_model.dart';
import 'package:gedu_bilibli/net/http_provider.dart';
import 'package:gedu_bilibli/widget/cached_network_image.dart';
import 'package:zoomable_image/zoomable_image.dart';

import 'package:flutter/material.dart';

class MeiZiDetail extends StatefulWidget {
  final List<GirlModel> _girlModels;
  final GirlModel _girl;

  MeiZiDetail(this._girlModels, this._girl);

  @override
  State<StatefulWidget> createState() => _MeiZiDetailState(_girlModels, _girl);
}

class _MeiZiDetailState extends State<MeiZiDetail> {
  List<GirlModel> _girlModels;
  GirlModel _girl;
  GankProvider gankProvider;

  _MeiZiDetailState(this._girlModels, this._girl);

  @override
  void initState() {
    gankProvider = GankProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(_girl.desc),
        ),
        body: PageView(
          onPageChanged: _onPageChange,
          children: _girlModels
              .map((GirlModel girl) => Container(
                    alignment: Alignment.center,
                    child: new CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeOutDuration: Duration(milliseconds: 100),
                      imageUrl: girl.url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 610.0,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _onPageChange(int position) {
    GirlModel curItem = _girlModels[position];
    setState(() {
      _girl = curItem;
    });
    // when scroll to the first position.
    if (position == 0) {
      if (curItem.page != null && curItem.page > 1) {
        _loadData(curItem.page - 1);
      }
      return;
    }
    if (curItem.page != null && position == _girlModels.length - 1) {
      _loadData(curItem.page + 1);
    }
  }

  void _loadData(int page) async {
    var girls = await gankProvider.loadMedia(10, page);
    setState(() {
      _girlModels.addAll(girls);
    });
  }
}
