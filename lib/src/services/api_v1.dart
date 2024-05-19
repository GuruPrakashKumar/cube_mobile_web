import 'dart:io';
import 'dart:html';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopos/src/config/const.dart';
import 'package:shopos/src/services/dio_interceptor.dart';
import 'package:flutter/foundation.dart';
class ApiV1Service {
  static final Dio _dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: Const.apiV1Url,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 50000),
    ),
  );
  const ApiV1Service();

  void addHeaderCookie(Map<String, String> headers) {
    _dio.options.headers.clear();
    _dio.options.headers.addAll(headers);
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static Future<String> getTokenSubuser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_subuser') ?? '';
  }
  ///
  Future<PersistCookieJar> initCookiesManager() async {
    // Cookie files will be saved in files in "./cookies"
    _dio.interceptors.clear();
    final cj = await getCookieJar();
    _dio.interceptors.add(CookieManager(cj));
    _dio.interceptors.add(CustomInterceptor());
    return cj;
  }

  static Future<PersistCookieJar> getCookieJar() async {
    Directory tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    if(kDebugMode)print(tempPath);
    return PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(tempPath),
    );
  }

  ///
  static Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    if(url != '/login') {
      String token = await getToken();
      String tokenSubuser = await getTokenSubuser();
      // _dio.options.headers = {
      //   'Authorization': token,
      //   // 'Authorization_subuser': tokenSubuser,
      // };
    }
    return await _dio.post(url, data: formData ?? data, );
  }

  ///
  static Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {

    if(kDebugMode)print("executing get request and cookie value is ${document.cookie}");
    String token = await getToken();
    String tokenSubuser = await getTokenSubuser();
    print(_dio.options.headers.entries);
    // _dio.options.headers = {
    //   'Authorization': token,
    //   // 'Authorization_subuser': tokenSubuser,
    // };
    return await _dio.get(url, queryParameters: queryParameters);
  }

  ///
  static Future<Response> putRequest(
    String url, {
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    String token = await getToken();
    String tokenSubuser = await getTokenSubuser();
    // _dio.options.headers = {
    //   'Authorization': token,
    //   // 'Authorization_subuser': tokenSubuser,
    // };
    return await _dio.put(url, data: formData ?? data, );
  }

  ///
  static Future<Response> deleteRequest(String url,
      {Map<String, dynamic>? data}) async {
    String token = await getToken();
    String tokenSubuser = await getTokenSubuser();
    // _dio.options.headers = {
    //   'Authorization': token,
    //   // 'Authorization_subuser': tokenSubuser,
    // };
    return await _dio.delete(url, );
  }
}
