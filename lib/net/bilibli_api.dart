
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:async';

import 'package:gedu_bilibli/model/bilibli_recommend.dart';
import 'package:gedu_bilibli/model/bilibli_recommend_banner.dart';

//首页推荐数据
const String BiliBli_Home_Recommend = "http://app.bilibili.com/x/show/old?platform=android&device=&build=412001";
//首页推荐banner
const String BiliBli_Home_Recommend_Banner = "http://app.bilibili.com/x/banner?plat=4&build=411007&channel=bilih5";

class BiliBliApiClient {
  static final _client = BiliBliApiClient._internal();
  final _http = HttpClient();

  BiliBliApiClient._internal();


  factory BiliBliApiClient() => _client;

  Future<dynamic> _getJson(Uri uri) async {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    return json.decode(transformedResponse);
  }


  ///首页推荐列表
  Future<List<RecommendInfo>> fetchRecommendInfoListModel() {
    return _getJson(Uri.parse(BiliBli_Home_Recommend)).then((json) => json['result']).then(
            (data) => data.map<RecommendInfo>((item) => RecommendInfo.fromJson(item)).toList());
  }



  ///首页推荐banner
  Future<List<RecommendBanner>> fetchRecommendBannerListModel() {
    return _getJson(Uri.parse(BiliBli_Home_Recommend_Banner)).then((json) => json['data']).then(
            (data) => data.map<RecommendBanner>((item) => RecommendBanner.fromJson(item)).toList());
  }
}