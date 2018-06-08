
import 'response_data.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';

abstract class BasePresenter {
  ///请求接口数据
  Future<ResponseData> fetch(
      {int page, dynamic query, Map<String, dynamic> body});



  ResponseData parseResponse(Response response) {
    print(response.body);
    ResponseData responseData;

    if (response.statusCode == HttpStatus.OK) {
      Map res = json.decode(response.body);
      responseData = new ResponseData(
          errorCode: res['errorCode'],
          errorMsg: res['errorMsg'],
          data: res['data']);
    } else {
      responseData = new ResponseData(
          errorCode: -1,
          errorMsg: "Request Server Error! Code:${response.statusCode}");
    }
    return responseData;
  }
}
