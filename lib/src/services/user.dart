import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopos/src/services/api_v1.dart';
import 'package:shopos/src/services/auth.dart';
import 'package:flutter/foundation.dart';
class UserService {
  const UserService();

  
  static Future<Response<dynamic>> me() async {
    var response;
    try {
      response = await ApiV1Service.getRequest('/me');
      if(kDebugMode)print("response of /me is  $response");
      // getNewToken();
    } catch (e) {
      if(kDebugMode)print('cube token expired');
      await getNewToken();
      response = await ApiV1Service.getRequest('/me');
    }

    return response;
  }

  // /// get new token from server
  static getNewToken() async {
    if(kDebugMode)print("getting new token");
    final response = await ApiV1Service.getRequest('/get-token');
    print("Response of getToken= ${response.data}");
    if ((response.statusCode ?? 400) > 300) {
      return null;
    }
    await AuthService().saveCookie(response);
  }

  /// shop open or close
  static shopStatus() async {
    final response = await ApiV1Service.getRequest('/change/shop-status');
    if ((response.statusCode ?? 400) > 300) {
      return null;
    }
    if(kDebugMode)print(response.data);
  }
}
