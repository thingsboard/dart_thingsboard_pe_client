import 'dart:convert';

import '../model/scheduler_event_models.dart';
import '../http/http_utils.dart';
import '../thingsboard_client_base.dart';

class SchedulerEventService {
  final ThingsboardClient _tbClient;

  factory SchedulerEventService(ThingsboardClient tbClient) {
    return SchedulerEventService._internal(tbClient);
  }

  SchedulerEventService._internal(this._tbClient);

  Future<SchedulerEventWithCustomerInfo?> getSchedulerEventInfo(
      String schedulerEventId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/schedulerEvent/info/$schedulerEventId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? SchedulerEventWithCustomerInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<SchedulerEvent?> getSchedulerEvent(String schedulerEventId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/schedulerEvent/$schedulerEventId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? SchedulerEvent.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<SchedulerEvent> saveSchedulerEvent(SchedulerEvent schedulerEvent,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/schedulerEvent',
        data: jsonEncode(schedulerEvent),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return SchedulerEvent.fromJson(response.data!);
  }

  Future<void> deleteSchedulerEvent(String schedulerEventId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/schedulerEvent/$schedulerEventId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<List<SchedulerEventWithCustomerInfo>> getSchedulerEvents(
      {String? type, RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{};
    if (type != null) {
      queryParams['type'] = type;
    }
    var response = await _tbClient.get<List<dynamic>>('/api/schedulerEvents',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!
        .map((e) => SchedulerEventWithCustomerInfo.fromJson(e))
        .toList();
  }

  Future<List<SchedulerEventInfo>> getSchedulerEventsByIds(
      List<String> schedulerEventIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/schedulerEvents',
        queryParameters: {'schedulerEventIds': schedulerEventIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => SchedulerEventInfo.fromJson(e)).toList();
  }

  Future<SchedulerEventInfo?> assignSchedulerEventToEdge(
      String edgeId, String schedulerEventId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.post<Map<String, dynamic>>(
            '/api/edge/$edgeId/schedulerEvent/$schedulerEventId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? SchedulerEventInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<SchedulerEventInfo?> unassignSchedulerEventFromEdge(
      String edgeId, String schedulerEventId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.delete<Map<String, dynamic>>(
            '/api/edge/$edgeId/schedulerEvent/$schedulerEventId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? SchedulerEventInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<List<SchedulerEventInfo>> getEdgeSchedulerEvents(String edgeId,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/edge/$edgeId/schedulerEvents',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => SchedulerEventInfo.fromJson(e)).toList();
  }
}
