import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

PageData<Role> parseRolePageData(Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => Role.fromJson(json));
}

class RoleService {
  final ThingsboardClient _tbClient;

  factory RoleService(ThingsboardClient tbClient) {
    return RoleService._internal(tbClient);
  }

  RoleService._internal(this._tbClient);

  Future<Role?> getRole(String roleId, {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/role/$roleId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null ? Role.fromJson(response.data!) : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<Role> saveRole(Role role, {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>('/api/role',
        data: jsonEncode(role),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return Role.fromJson(response.data!);
  }

  Future<void> deleteRole(String roleId, {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/role/$roleId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<PageData<Role>> getRoles(PageLink pageLink,
      {RoleType? type, RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    if (type != null) {
      queryParams['type'] = type.toShortString();
    }
    var response = await _tbClient.get<Map<String, dynamic>>('/api/roles',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseRolePageData, response.data!);
  }

  Future<List<Role>> getRolesByIds(List<String> roleIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/roles',
        queryParameters: {'roleIds': roleIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => Role.fromJson(e)).toList();
  }
}
