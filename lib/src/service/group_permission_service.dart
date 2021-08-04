import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

class GroupPermissionService {
  final ThingsboardClient _tbClient;

  factory GroupPermissionService(ThingsboardClient tbClient) {
    return GroupPermissionService._internal(tbClient);
  }

  GroupPermissionService._internal(this._tbClient);

  Future<GroupPermission?> getGroupPermission(String groupPermissionId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/groupPermission/$groupPermissionId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? GroupPermission.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<GroupPermissionInfo?> getGroupPermissionInfo(
      String groupPermissionId, bool isUserGroup,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/groupPermission/info/$groupPermissionId',
            queryParameters: {'isUserGroup': isUserGroup},
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? GroupPermissionInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<GroupPermission> saveGroupPermission(GroupPermission groupPermission,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/groupPermission',
        data: jsonEncode(groupPermission),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return GroupPermission.fromJson(response.data!);
  }

  Future<void> deleteGroupPermission(String groupPermissionId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/groupPermission/$groupPermissionId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<List<GroupPermissionInfo>> getUserGroupPermissions(String userGroupId,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/userGroup/$userGroupId/groupPermissions',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => GroupPermissionInfo.fromJson(e)).toList();
  }

  Future<List<GroupPermissionInfo>> loadUserGroupPermissionInfos(
      List<GroupPermission> permissions,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<List<dynamic>>(
        '/api/userGroup/groupPermissions/info',
        data: jsonEncode(permissions),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => GroupPermissionInfo.fromJson(e)).toList();
  }

  Future<List<GroupPermissionInfo>> getEntityGroupPermissions(
      String entityGroupId,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/entityGroup/$entityGroupId/groupPermissions',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => GroupPermissionInfo.fromJson(e)).toList();
  }
}
