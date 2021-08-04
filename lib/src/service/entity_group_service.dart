import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

PageData<ShortEntityView> parseShortEntityViewPageData(
    Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => ShortEntityView.fromJson(json));
}

PageData<ContactBased> parseContactBasedPageData(Map<String, dynamic> json) {
  return PageData.fromJson(
      json, (json) => ContactBased.contactBasedFromJson(json));
}

class EntityGroupService {
  final ThingsboardClient _tbClient;

  factory EntityGroupService(ThingsboardClient tbClient) {
    return EntityGroupService._internal(tbClient);
  }

  EntityGroupService._internal(this._tbClient);

  Future<EntityGroupInfo?> getEntityGroup(String entityGroupId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/entityGroup/$entityGroupId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? EntityGroupInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<EntityGroupInfo> saveEntityGroup(EntityGroup entityGroup,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup',
        data: jsonEncode(entityGroup),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return EntityGroupInfo.fromJson(response.data!);
  }

  Future<void> deleteEntityGroup(String entityGroupId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/entityGroup/$entityGroupId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<List<EntityGroupInfo>> getEntityGroupsByType(EntityType groupType,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/entityGroups/${groupType.toShortString()}',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => EntityGroupInfo.fromJson(e)).toList();
  }

  Future<List<EntityGroupInfo>> getEntityGroupsByOwnerAndType(
      EntityId ownerId, EntityType groupType,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/entityGroups/${ownerId.entityType.toShortString()}/${ownerId.id}/${groupType.toShortString()}',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => EntityGroupInfo.fromJson(e)).toList();
  }

  Future<EntityGroupInfo?> getEntityGroupAllByOwnerAndType(
      EntityId ownerId, EntityType groupType,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/entityGroup/all/${ownerId.entityType.toShortString()}/${ownerId.id}/${groupType.toShortString()}',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? EntityGroupInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<EntityGroupInfo?> getEntityGroupInfoByOwnerAndNameAndType(
      EntityId ownerId, EntityType groupType, String groupName,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/entityGroup/all/${ownerId.entityType.toShortString()}/${ownerId.id}/${groupType.toShortString()}/$groupName',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? EntityGroupInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<void> addEntitiesToEntityGroup(
      String entityGroupId, List<String> entityIds,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/addEntities',
        data: jsonEncode(entityIds),
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<void> removeEntitiesFromEntityGroup(
      String entityGroupId, List<String> entityIds,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/deleteEntities',
        data: jsonEncode(entityIds),
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<ShortEntityView?> getGroupEntity(String entityGroupId, String entityId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/entityGroup/$entityGroupId/$entityId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? ShortEntityView.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<PageData<ShortEntityView>> getEntities(
      String entityGroupId, PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/entities',
        queryParameters: pageLink.toQueryParameters(),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseShortEntityViewPageData, response.data!);
  }

  Future<List<EntityGroupId>> getEntityGroupsForEntity(EntityId entityId,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/entityGroups/${entityId.entityType.toShortString()}/${entityId.id}',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => EntityGroupId.fromJson(e)).toList();
  }

  Future<List<EntityGroup>> getEntityGroupsByIds(List<String> entityGroupIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/entityGroups',
        queryParameters: {'entityGroupIds': entityGroupIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => EntityGroup.fromJson(e)).toList();
  }

  Future<PageData<ContactBased>> getOwners(PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>('/api/owners',
        queryParameters: pageLink.toQueryParameters(),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseContactBasedPageData, response.data!);
  }

  Future<void> makeEntityGroupPublic(String entityGroupId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/makePublic',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<void> makeEntityGroupPrivate(String entityGroupId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/makePrivate',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<void> shareEntityGroup(
      String entityGroupId, ShareGroupRequest shareGroupRequest,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/share',
        data: jsonEncode(shareGroupRequest),
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<void> shareEntityGroupToChildOwnerUserGroup(
      String entityGroupId, String userGroupId, String roleId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/$userGroupId/$roleId/share',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<EntityGroup?> assignEntityGroupToEdge(
      String edgeId, String entityGroupId, EntityType groupType,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.post<Map<String, dynamic>>(
            '/api/edge/$edgeId/entityGroup/$entityGroupId/${groupType.toShortString()}',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? EntityGroup.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<EntityGroup?> unassignEntityGroupFromEdge(
      String edgeId, String entityGroupId, EntityType groupType,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.delete<Map<String, dynamic>>(
            '/api/edge/$edgeId/entityGroup/$entityGroupId/${groupType.toShortString()}',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? EntityGroup.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<List<EntityGroupInfo>> getEdgeEntityGroups(
      String edgeId, EntityType groupType,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>(
        '/api/entityGroups/edge/$edgeId/${groupType.toShortString()}',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => EntityGroupInfo.fromJson(e)).toList();
  }
}
