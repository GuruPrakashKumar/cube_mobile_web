import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopos/src/models/input/order.dart';

import 'package:shopos/src/models/party.dart';
import 'package:shopos/src/services/api_v1.dart';
import 'package:flutter/foundation.dart';
class SpecificPartyService {
  ///

  Future<List<Order>> getSalesCreditHistory(String id) async {
    if(kDebugMode)print("--line 11 in specific party");
    if(kDebugMode)print(id);
    final response = await ApiV1Service.getRequest('/sales/credit-history/$id');
    if(kDebugMode)print("CreditData");
    if(kDebugMode)print(response.data);
    if(kDebugMode)print("----");
 
    
    return (response.data['data'] as List)
        .map((e) => Order.fromMapForParty(e as Map<String, dynamic>))
        .toList();
  }

  ///
  Future<List<Order>> getpurchaseCreditHistory(String id) async {
    final response =
        await ApiV1Service.getRequest('/purchase/credit-history/$id');
    return (response.data['data'] as List)
        .map((e) => Order.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  ///
  Future<Response> updateSalesCredit(Party party) async {
    if(kDebugMode)print("line 37 in specific party");
    if(kDebugMode)print(jsonEncode(party.toMap()).toString());
    return await ApiV1Service.postRequest(
      '/sales/credit-history/${party.id}',
      data: party.toMap(),
    );
  }

  ///
  Future<Response> updatepurchasedCredit(Party party) async {
    return await ApiV1Service.postRequest(
      '/purchase/credit-history/${party.id}',
      data: party.toMap(),
    );
  }

  ///
  Future<Party> getCreditPurchaseParty(String id) async {
    final response =
        await ApiV1Service.getRequest('/party/purchase/credit/$id');
    return Party.fromMap(response.data['data'] as Map<String, dynamic>);
  }

  ///
  Future<Party> getCreditSaleParty(String id) async {
    if(kDebugMode)print("line 60 in specific party");
    final response = await ApiV1Service.getRequest('/party/sale/credit/$id');
    if(kDebugMode)print("line 62 in specific party");
    return Party.fromMap(response.data['data'] as Map<String, dynamic>);
  }

  ///
  Future<Response> updatepurchasedAmount(String id, double total) async {
    return await ApiV1Service.putRequest(
      '/upd/purchaseOrder/${id}',
      data: {"total": total},
    );
  }

  ///
  Future<Response> updateSaleAmount(String id, double total) async {
    if(kDebugMode)print("party edit:");
    if(kDebugMode)print(id);
    if(kDebugMode)print(total);
    return await ApiV1Service.putRequest(
      '/upd/salesOrder/${id}',
      data: {"total": total},
    );

  }

  ///
  Future<Response> deletesaleAmount(String id) async {
    final response = await ApiV1Service.deleteRequest('/salesOrder/$id');
    return response;
  }

  ///
  Future<Response> deletepurchaseAmount(String id) async {
    final response = await ApiV1Service.deleteRequest('/purchaseOrder/$id');
    return response;
  }
}
