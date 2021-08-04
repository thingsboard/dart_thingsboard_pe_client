import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

PageData<DashboardInfo> parseDashboardInfoPageData(Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => DashboardInfo.fromJson(json));
}

class DashboardService {
  final ThingsboardClient _tbClient;

  factory DashboardService(ThingsboardClient tbClient) {
    return DashboardService._internal(tbClient);
  }

  DashboardService._internal(this._tbClient);

  Future<int> getServerTime({RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<int>('/api/dashboard/serverTime',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!;
  }

  Future<int> getMaxDatapointsLimit({RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<int>('/api/dashboard/maxDatapointsLimit',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!;
  }

  Future<PageData<DashboardInfo>> getTenantDashboards(PageLink pageLink,
      {bool? mobile, RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    if (mobile != null) {
      queryParams['mobile'] = mobile;
    }
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/tenant/dashboards',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseDashboardInfoPageData, response.data!);
  }

  Future<PageData<DashboardInfo>> getTenantDashboardsByTenantId(
      String tenantId, PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/tenant/$tenantId/dashboards',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseDashboardInfoPageData, response.data!);
  }

  Future<PageData<DashboardInfo>> getUserDashboards(PageLink pageLink,
      {bool? mobile,
      Operation? operation,
      String? userId,
      RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    if (operation != null) {
      queryParams['operation'] = operation.toShortString();
    }
    if (userId != null) {
      queryParams['userId'] = userId;
    }
    if (mobile != null) {
      queryParams['mobile'] = mobile;
    }
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/user/dashboards',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseDashboardInfoPageData, response.data!);
  }

  Future<List<DashboardInfo>> getDashboardsByIds(List<String> dashboardIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/dashboards',
        queryParameters: {'dashboardIds': dashboardIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => DashboardInfo.fromJson(e)).toList();
  }

  Future<PageData<DashboardInfo>> getGroupDashboards(
      String entityGroupId, PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/dashboards',
        queryParameters: pageLink.toQueryParameters(),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseDashboardInfoPageData, response.data!);
  }

  Future<void> importGroupDashboards(
      String entityGroupId, List<Dashboard> dashboardList,
      {bool? overwrite, RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{};
    if (overwrite != null) {
      queryParams['overwrite'] = overwrite;
    }
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/dashboards/import',
        queryParameters: queryParams,
        data: jsonEncode(dashboardList),
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<List<Dashboard>> exportGroupDashboards(String entityGroupId, int limit,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/entityGroup/$entityGroupId/dashboards/export',
        queryParameters: {'limit': limit},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => Dashboard.fromJson(e)).toList();
  }

  Future<Dashboard?> getDashboard(String dashboardId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/dashboard/$dashboardId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? Dashboard.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<DashboardInfo?> getDashboardInfo(String dashboardId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/dashboard/info/$dashboardId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? DashboardInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<Dashboard> saveDashboard(Dashboard dashboard,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>('/api/dashboard',
        data: jsonEncode(dashboard),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return Dashboard.fromJson(response.data!);
  }

  Future<void> deleteDashboard(String dashboardId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/dashboard/$dashboardId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<HomeDashboard?> getHomeDashboard(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<dynamic>('/api/dashboard/home',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data != null && response.data is Map
        ? HomeDashboard.fromJson(response.data!)
        : null;
  }

  Future<HomeDashboardInfo?> getHomeDashboardInfo(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<dynamic>('/api/dashboard/home/info',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data != null && response.data is Map
        ? HomeDashboardInfo.fromJson(response.data!)
        : null;
  }

  Future<HomeDashboardInfo> getTenantHomeDashboardInfo(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/tenant/dashboard/home/info',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return HomeDashboardInfo.fromJson(response.data!);
  }

  Future<void> setTenantHomeDashboardInfo(HomeDashboardInfo homeDashboardInfo,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/tenant/dashboard/home/info',
        data: jsonEncode(homeDashboardInfo),
        options: defaultHttpOptionsFromConfig(requestConfig));
  }
}
