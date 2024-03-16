import 'package:shopos/src/models/online_order.dart';
import 'package:flutter/foundation.dart';
// import 'api_v1.dart';
import 'package:shopos/src/services/api_v1.dart';

class OrderServices {
  //const OrderServices()

  static Future<List<OnlineOrder>> orderHistory() async {
    final response = await ApiV1Service.getRequest('/myorders');
    if(kDebugMode)print(response.data);
    return (response.data as List)
        .map((e) => OnlineOrder.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
