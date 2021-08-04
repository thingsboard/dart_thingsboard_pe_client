import 'dart:convert';

import 'package:dio/dio.dart';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

class ReportService {
  final ThingsboardClient _tbClient;

  factory ReportService(ThingsboardClient tbClient) {
    return ReportService._internal(tbClient);
  }

  ReportService._internal(this._tbClient);

  Future<ResponseBody?> downloadDashboardReport(
      String dashboardId, ReportParams reportParams,
      {RequestConfig? requestConfig}) async {
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.stream;
    var response = await _tbClient.post<ResponseBody>(
        '/api/report/$dashboardId/download',
        data: jsonEncode(reportParams),
        options: options);
    return response.data;
  }

  Future<ResponseBody?> downloadTestReport(ReportConfig reportConfig,
      {String? reportsServerEndpointUrl, RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{};
    if (reportsServerEndpointUrl != null) {
      queryParams['reportsServerEndpointUrl'] = reportsServerEndpointUrl;
    }
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.stream;
    var response = await _tbClient.post<ResponseBody>('/api/report/test',
        queryParameters: queryParams,
        data: jsonEncode(reportConfig),
        options: options);
    return response.data;
  }
}
