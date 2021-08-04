import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

PageData<Integration> parseIntegrationPageData(Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => Integration.fromJson(json));
}

class IntegrationService {
  final ThingsboardClient _tbClient;

  factory IntegrationService(ThingsboardClient tbClient) {
    return IntegrationService._internal(tbClient);
  }

  IntegrationService._internal(this._tbClient);

  Future<Integration?> getIntegration(String integrationId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/integration/$integrationId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? Integration.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<Integration?> getIntegrationByRoutingKey(String routingKey,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/integration/routingKey/$routingKey',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? Integration.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<Integration> saveIntegration(Integration integration,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/integration',
        data: jsonEncode(integration),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return Integration.fromJson(response.data!);
  }

  Future<void> deleteIntegration(String integrationId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/integration/$integrationId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<void> checkIntegrationConnection(Integration integration,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/integration/check',
        data: jsonEncode(integration),
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<PageData<Integration>> getIntegrations(PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/integrations',
        queryParameters: pageLink.toQueryParameters(),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseIntegrationPageData, response.data!);
  }

  Future<List<Integration>> getIntegrationsByIds(List<String> integrationIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/integrations',
        queryParameters: {'integrationIds': integrationIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => Integration.fromJson(e)).toList();
  }
}
