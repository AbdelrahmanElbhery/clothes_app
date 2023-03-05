import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Maindio {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response?> getdata({
    @required String? path,
    Map<String, dynamic>? query,
    String? language = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token
    };
    return await dio?.get(path!, queryParameters: query);
  }

  static Future<Response?> postdata({
    @required String? path,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    String? language = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token
    };
    return await dio?.post(path!, queryParameters: query, data: data);
  }

  static Future<Response?> putdata({
    @required String? path,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    String? language = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token
    };
    return await dio?.put(path!, queryParameters: query, data: data);
  }
}
