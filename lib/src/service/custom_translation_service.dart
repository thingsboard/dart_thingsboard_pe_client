import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

class CustomTranslationService {
  final ThingsboardClient _tbClient;

  factory CustomTranslationService(ThingsboardClient tbClient) {
    return CustomTranslationService._internal(tbClient);
  }

  CustomTranslationService._internal(this._tbClient);

  Future<CustomTranslation?> getCustomTranslation(
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/customTranslation/customTranslation',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? CustomTranslation.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<CustomTranslation?> getCurrentCustomTranslation(
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/customTranslation/currentCustomTranslation',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? CustomTranslation.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<CustomTranslation> saveCustomTranslation(
      CustomTranslation customTranslation,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/customTranslation/customTranslation',
        data: jsonEncode(customTranslation),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return CustomTranslation.fromJson(response.data!);
  }
}
