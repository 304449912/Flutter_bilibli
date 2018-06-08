import 'package:flutter/material.dart';
import 'package:gedu_bilibli/model/girl_model.dart';
import 'package:gedu_bilibli/ui/meizi/picture_meizi_detail.dart';
import 'package:gedu_bilibli/ui/meizi/prcture_meizi.dart';

goToImage(BuildContext context, GirlModel girl) {
  _pushWidgetWithFade(context, new Text(girl.who));
}

goToMeizi(BuildContext context) {
  _pushWidgetWithFade(context, MeiZiListPage());
}

goToMeiZiDetail(BuildContext context,List<GirlModel> girlModels,GirlModel girl) {
  _pushWidgetWithFade(context,MeiZiDetail(girlModels,girl));
}

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
        PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return widget;
            }),
      );
}
