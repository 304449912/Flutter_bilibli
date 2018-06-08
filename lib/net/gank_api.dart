
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gedu_bilibli/model/girl_model.dart';


const  String GANK_URL="http://gank.io/api/data/";

class GankApiClient {
  static final _client = GankApiClient._internal();
  final _http = HttpClient();

  GankApiClient._internal();


  factory GankApiClient() => _client;

  Future<dynamic> _getJson(Uri uri) async {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    return json.decode(transformedResponse);
  }





  /**
   * 获取美女福利接口
   */
  Future<List<GirlModel>> fetchGirlModel(int pageSize, int pageNum) {
    var url = GANK_URL + '福利/$pageSize/$pageNum';

    return _getJson(Uri.parse(url)).then((json) => json['results']).then(
            (data) => data.map<GirlModel>((item) => GirlModel.fromJson(item,pageNum)).toList());
  }
}