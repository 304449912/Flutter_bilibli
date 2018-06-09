
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:gedu_bilibli/model/bilibli_bangumi_banner.dart';
import 'package:gedu_bilibli/model/bilibli_bangumi_info.dart';
import 'package:gedu_bilibli/model/bilibli_recommend.dart';
import 'package:gedu_bilibli/model/bilibli_recommend_banner.dart';

//首页推荐数据
const String BiliBli_Home_Recommend = "http://app.bilibili.com/x/show/old?platform=android&device=&build=412001";

//首页推荐banner
const String BiliBli_Home_Recommend_Banner = "http://app.bilibili.com/x/banner?plat=4&build=411007&channel=bilih5";

//首页番剧banner
const String BiliBli_Home_Bangumi_Banner = "http://bangumi.bilibili.com/api/app_index_page_v4?build=3940&device=phone&mobi_app=iphone&platform=ios";

//首页番剧推荐
const String BiliBli_Home_Bangumi_Recommend = "http://bangumi.bilibili.com/api/bangumi_recommend?access_key=f5bd4e793b82fba5aaf5b91fb549910a&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&cursor=0&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=56329a5709c401d4d7c0237f64f7943f&ts=1469613558";

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

  ///首页番剧banner
  Future<BangUmiRecommend> fetchBangUmiRecommendModel() {
    return _getJson(Uri.parse(BiliBli_Home_Bangumi_Banner)).then((json) => json['result']).then(
            (data) =>  BangUmiRecommend.fromJson(data))  ;
  }

  ///首页新番推荐
  Future<List<BangUmiInfo>> fetchBangUmiInfoListModel() {
    return _getJson(Uri.parse(BiliBli_Home_Bangumi_Recommend)).then((json) => json['result']).then(
            (data) => data.map<BangUmiInfo>((item) => BangUmiInfo.fromJson(item)).toList());
  }
}