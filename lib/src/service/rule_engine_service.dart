import 'package:dio/dio.dart';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

class RuleEngineService {
  final ThingsboardClient _tbClient;

  factory RuleEngineService(ThingsboardClient tbClient) {
    return RuleEngineService._internal(tbClient);
  }

  RuleEngineService._internal(this._tbClient);

  Future<dynamic> handleRuleEngineRequest(String requestBody,
      {EntityId? entityId, int? timeout, RequestConfig? requestConfig}) async {
    var url = '/api/rule-engine';
    if (entityId != null) {
      url += '/${entityId.entityType.toShortString()}/${entityId.id}';
      if (timeout != null) {
        url += '/$timeout';
      }
    }
    var response = await _tbClient.post<ResponseBody>(url,
        data: requestBody,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data;
  }
}
