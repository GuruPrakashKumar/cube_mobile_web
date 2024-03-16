import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shopos/src/models/input/report_input.dart';
import 'package:shopos/src/services/api_v1.dart';

class ReportService {
  const ReportService();

  Future<String> getCurrentDate() async {
    final response = await ApiV1Service.getRequest('/current-date');
    return response.data['date'];
  }
  ///
  Future<Response> getAllReport(ReportInput input) async {
    if(kDebugMode)print(input.type);
    if(kDebugMode)print(input.startDate);
    if(kDebugMode)print(input.endDate);
    if(kDebugMode)print('ok');
    final response = await ApiV1Service.getRequest(
      '/report',
      queryParameters: input.toMap(),
    );
    if(kDebugMode)print("--line 18 in report.dart");
    // if(kDebugMode)print("response:${response.data}");
    if(kDebugMode)print("--------------");

    
    return response;
  }

  ///
  Future<Response> getStockReport() async {
    final response = await ApiV1Service.getRequest(
      '/report?type=report',
    );
    return response;
  }
}
