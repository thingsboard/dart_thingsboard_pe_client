import 'dart:convert';
import 'package:dio/dio.dart';

import '../model/white_labeling_models.dart';
import '../http/http_utils.dart';
import '../thingsboard_client_base.dart';

class WhiteLabelingService {
  final ThingsboardClient _tbClient;

  factory WhiteLabelingService(ThingsboardClient tbClient) {
    return WhiteLabelingService._internal(tbClient);
  }

  WhiteLabelingService._internal(this._tbClient);

  Future<WhiteLabelingParams> getWhiteLabelParams(
      {String? logoImageChecksum,
      String? faviconChecksum,
      RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{};
    if (logoImageChecksum != null) {
      queryParams['logoImageChecksum'] = logoImageChecksum;
    }
    if (faviconChecksum != null) {
      queryParams['faviconChecksum'] = faviconChecksum;
    }
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/whiteLabel/whiteLabelParams',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return WhiteLabelingParams.fromJson(response.data!);
  }

  Future<LoginWhiteLabelingParams> getLoginWhiteLabelParams(
      {String? logoImageChecksum,
      String? faviconChecksum,
      RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{};
    if (logoImageChecksum != null) {
      queryParams['logoImageChecksum'] = logoImageChecksum;
    }
    if (faviconChecksum != null) {
      queryParams['faviconChecksum'] = faviconChecksum;
    }
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/noauth/whiteLabel/loginWhiteLabelParams',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return LoginWhiteLabelingParams.fromJson(response.data!);
  }

  Future<WhiteLabelingParams> getCurrentWhiteLabelParams(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/whiteLabel/currentWhiteLabelParams',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return WhiteLabelingParams.fromJson(response.data!);
  }

  Future<LoginWhiteLabelingParams> getCurrentLoginWhiteLabelParams(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/whiteLabel/currentLoginWhiteLabelParams',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return LoginWhiteLabelingParams.fromJson(response.data!);
  }

  Future<WhiteLabelingParams> saveWhiteLabelParams(
      WhiteLabelingParams whiteLabelingParams,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/whiteLabel/whiteLabelParams',
        data: jsonEncode(whiteLabelingParams),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return WhiteLabelingParams.fromJson(response.data!);
  }

  Future<LoginWhiteLabelingParams> saveLoginWhiteLabelParams(
      LoginWhiteLabelingParams loginWhiteLabelingParams,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/whiteLabel/loginWhiteLabelParams',
        data: jsonEncode(loginWhiteLabelingParams),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return LoginWhiteLabelingParams.fromJson(response.data!);
  }

  Future<WhiteLabelingParams> previewWhiteLabelParams(
      WhiteLabelingParams whiteLabelingParams,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/whiteLabel/previewWhiteLabelParams',
        data: jsonEncode(whiteLabelingParams),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return WhiteLabelingParams.fromJson(response.data!);
  }

  Future<bool> isWhiteLabelingAllowed({RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<bool>(
        '/api/whiteLabel/isWhiteLabelingAllowed',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!;
  }

  Future<bool> isCustomerWhiteLabelingAllowed(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<bool>(
        '/api/whiteLabel/isCustomerWhiteLabelingAllowed',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!;
  }

  Future<String> getLoginThemeCss(PaletteSettings paletteSettings,
      {bool? darkForeground, RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{};
    if (darkForeground != null) {
      queryParams['darkForeground'] = darkForeground;
    }
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.plain;
    var response = await _tbClient.post<String>(
        '/api/noauth/whiteLabel/loginThemeCss',
        queryParameters: queryParams,
        data: jsonEncode(paletteSettings),
        options: options);
    return response.data!;
  }

  Future<String> getAppThemeCss(PaletteSettings paletteSettings,
      {RequestConfig? requestConfig}) async {
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.plain;
    var response = await _tbClient.post<String>('/api/whiteLabel/appThemeCss',
        data: jsonEncode(paletteSettings), options: options);
    return response.data!;
  }
}
