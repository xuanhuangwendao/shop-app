import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComResponse<T> {
  int code;
  String? msg;
  T? data;

  ComResponse({required this.code, this.msg, this.data});
}


class NetResponse <T> { 
  bool success;
  T? model;
  int code;
  String message;

  NetResponse(this.success, this.model, this.code, this.message);
}


class NetRequest {
  var dio = Dio();

  Future<NetResponse<T>> request<T>(String path,
      {Map<String, dynamic>? params,
        dynamic data,
        String method = "get"}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      dio.options.headers['token'] = token;
      dio.options.contentType =  Headers.formUrlEncodedContentType;
      final response = method == "get"
          ? await dio.get(path, queryParameters: params)
          : await dio.post(path, data: data);
      return NetResponse(
          response.data['success'],
          response.data['model'],
          response.data['code'],
          response.data['message']
      );
    } on DioError catch(e) {
      print("dioError" + e.message);
      return Future.error(e.type.name + ":"  + e.message);
    }
  }
}
