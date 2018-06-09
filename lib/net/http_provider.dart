
import 'dart:async';

import 'package:gedu_bilibli/model/bilibli_bangumi_banner.dart';
import 'package:gedu_bilibli/model/bilibli_bangumi_info.dart';
import 'package:gedu_bilibli/model/bilibli_recommend.dart';
import 'package:gedu_bilibli/model/bilibli_recommend_banner.dart';
import 'package:gedu_bilibli/model/girl_model.dart';
import 'package:gedu_bilibli/net/bilibli_api.dart';
import 'package:gedu_bilibli/net/gank_api.dart';


class GankProvider {

  GankProvider();

  GankApiClient _apiClient = GankApiClient();

  Future<List<GirlModel>> loadMedia(int pageSize, int pageNum) {
    return _apiClient.fetchGirlModel( pageSize,  pageNum);
  }

}



class BiliBliProvider {

  BiliBliProvider();

  BiliBliApiClient _apiClient = BiliBliApiClient();

  ///首页推荐列表
  Future<List<RecommendInfo>>  fetchRecommendInfoListModel() {
    return _apiClient.fetchRecommendInfoListModel();
  }

  ///首页推荐banner
  Future<List<RecommendBanner>>  fetchRecommendBannerListModel() {
    return _apiClient.fetchRecommendBannerListModel();
  }

  ///首页番剧banner
  Future<BangUmiRecommend> fetchBangUmiRecommendModel() {
    return _apiClient.fetchBangUmiRecommendModel();
  }

  ///首页新番推荐
  Future<List<BangUmiInfo>> fetchBangUmiInfoListModel() {
    return _apiClient.fetchBangUmiInfoListModel();
  }

}