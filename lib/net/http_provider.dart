
import 'dart:async';

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


  Future<List<RecommendInfo>>  fetchRecommendInfoListModel() {
    return _apiClient.fetchRecommendInfoListModel();
  }

  Future<List<RecommendBanner>>  fetchRecommendBannerListModel() {
    return _apiClient.fetchRecommendBannerListModel();
  }

}