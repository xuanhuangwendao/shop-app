import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ComResponse<T> {
  int code;
  String? msg;
  T? data;

  ComResponse({required this.code, this.msg, this.data});
}

class NetRequest {
  var dio = Dio();

  Future<ComResponse<T>> requestData<T>(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      String method = "get"}) async {
    try {
      final response = method == "get"
          ? await dio.get(path, queryParameters: params)
          : await dio.post(path, data: data);
      return ComResponse(
          code: response.data['code'],
          msg: response.data['msg'],
          data: response.data['data']
      );
    } on DioError catch(e) {
      print(e.message);
      return Future.error(e.type.name + ":"  + e.message);
    }
  }
}
