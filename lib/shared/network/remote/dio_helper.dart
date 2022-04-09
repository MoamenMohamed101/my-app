import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Diohelper {
  static Dio? dio;
  static inti() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response>? getdataa({
    @required String? path,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio!.get(path!, queryParameters: query);
  }

  static Future<Response>? postdata({
    @required String? url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio!.post(url!, data: data, queryParameters: query);
  }
  static Future<Response>? putData({
    @required String? url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio!.put(url!, data: data, queryParameters: query);
  }
}
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// class Diohelper {
//   static Dio? dio;
//   static inti() {
//     dio = Dio(
//       BaseOptions(
//         // connectTimeout: 20 * 1000,
//         // receiveTimeout: 20 * 1000,
//         baseUrl: 'https://newsapi.org/',
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }
//
//   static Future<Response>? getdataa({
//     @required String? path,
//     @required Map<String, dynamic>? query,
//   }) async {
//     return await dio!.get(path!, queryParameters: query);
//   }
// }
