import 'entity_group_models.dart';
import 'entity_type_models.dart';
import 'id/entity_group_id.dart';
import 'id/entity_id.dart';

enum RoleType { GENERIC, GROUP }

RoleType roleTypeFromString(String value) {
  return RoleType.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension RoleTypeToString on RoleType {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum Operation {
  ALL,
  CREATE,
  READ,
  WRITE,
  DELETE,
  RPC_CALL,
  READ_CREDENTIALS,
  WRITE_CREDENTIALS,
  READ_ATTRIBUTES,
  WRITE_ATTRIBUTES,
  READ_TELEMETRY,
  WRITE_TELEMETRY,
  ADD_TO_GROUP,
  REMOVE_FROM_GROUP,
  CHANGE_OWNER,
  IMPERSONATE,
  CLAIM_DEVICES,
  SHARE_GROUP,
  ASSIGN_TO_TENANT,
  ASSIGN_TO_EDGE,
  UNASSIGN_FROM_EDGE
}

Operation operationFromString(String value) {
  return Operation.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension OperationToString on Operation {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum Resource {
  ALL,
  PROFILE,
  ADMIN_SETTINGS,
  ALARM,
  DEVICE,
  ASSET,
  CUSTOMER,
  DASHBOARD,
  ENTITY_VIEW,
  EDGE,
  TENANT,
  RULE_CHAIN,
  USER,
  WIDGETS_BUNDLE,
  WIDGET_TYPE,
  OAUTH2_CONFIGURATION_INFO,
  OAUTH2_CONFIGURATION_TEMPLATE,
  TENANT_PROFILE,
  DEVICE_PROFILE,
  CONVERTER,
  INTEGRATION,
  SCHEDULER_EVENT,
  BLOB_ENTITY,
  CUSTOMER_GROUP,
  DEVICE_GROUP,
  ASSET_GROUP,
  USER_GROUP,
  ENTITY_VIEW_GROUP,
  EDGE_GROUP,
  DASHBOARD_GROUP,
  ROLE,
  GROUP_PERMISSION,
  WHITE_LABELING,
  AUDIT_LOG,
  API_USAGE_STATE,
  TB_RESOURCE,
  OTA_PACKAGE
}

Resource resourceFromString(String value) {
  return Resource.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension ResourceToString on Resource {
  String toShortString() {
    return toString().split('.').last;
  }
}

const resourceByEntityType = <EntityType, Resource>{
  EntityType.ALARM: Resource.ALARM,
  EntityType.DEVICE: Resource.DEVICE,
  EntityType.DEVICE_PROFILE: Resource.DEVICE_PROFILE,
  EntityType.ASSET: Resource.ASSET,
  EntityType.CUSTOMER: Resource.CUSTOMER,
  EntityType.DASHBOARD: Resource.DASHBOARD,
  EntityType.ENTITY_VIEW: Resource.ENTITY_VIEW,
  EntityType.TENANT: Resource.TENANT,
  EntityType.TENANT_PROFILE: Resource.TENANT_PROFILE,
  EntityType.RULE_CHAIN: Resource.RULE_CHAIN,
  EntityType.USER: Resource.USER,
  EntityType.WIDGETS_BUNDLE: Resource.WIDGETS_BUNDLE,
  EntityType.WIDGET_TYPE: Resource.WIDGET_TYPE,
  EntityType.CONVERTER: Resource.CONVERTER,
  EntityType.INTEGRATION: Resource.INTEGRATION,
  EntityType.SCHEDULER_EVENT: Resource.SCHEDULER_EVENT,
  EntityType.BLOB_ENTITY: Resource.BLOB_ENTITY,
  EntityType.ROLE: Resource.ROLE,
  EntityType.GROUP_PERMISSION: Resource.GROUP_PERMISSION,
  EntityType.TB_RESOURCE: Resource.TB_RESOURCE,
  EntityType.EDGE: Resource.EDGE,
  EntityType.OTA_PACKAGE: Resource.OTA_PACKAGE
};

const groupResourceByGroupType = <EntityType, Resource>{
  EntityType.CUSTOMER: Resource.CUSTOMER_GROUP,
  EntityType.DEVICE: Resource.DEVICE_GROUP,
  EntityType.ASSET: Resource.ASSET_GROUP,
  EntityType.USER: Resource.USER_GROUP,
  EntityType.ENTITY_VIEW: Resource.ENTITY_VIEW_GROUP,
  EntityType.DASHBOARD: Resource.DASHBOARD_GROUP,
  EntityType.EDGE: Resource.EDGE_GROUP
};

class MergedGroupPermissionInfo {
  EntityType entityType;
  Set<Operation> operations;

  MergedGroupPermissionInfo.fromJson(Map<String, dynamic> json)
      : entityType = entityTypeFromString(json['entityType']),
        operations = (json['operations'] as List<dynamic>)
            .map((e) => operationFromString(e))
            .toSet();

  @override
  String toString() {
    return 'MergedGroupPermissionInfo{entityType: $entityType, operations: $operations}';
  }
}

class MergedGroupTypePermissionInfo {
  List<EntityGroupId> entityGroupIds;
  bool hasGenericRead;

  MergedGroupTypePermissionInfo.fromJson(Map<String, dynamic> json)
      : entityGroupIds = (json['entityGroupIds'] as List<dynamic>)
            .map((e) => EntityGroupId.fromJson(e))
            .toList(),
        hasGenericRead = json['hasGenericRead'];

  @override
  String toString() {
    return 'MergedGroupTypePermissionInfo{entityGroupIds: $entityGroupIds, hasGenericRead: $hasGenericRead}';
  }
}

class MergedUserPermissions {
  Map<Resource, Set<Operation>> genericPermissions;
  Map<String, MergedGroupPermissionInfo> groupPermissions;
  Map<EntityType, MergedGroupTypePermissionInfo> readGroupPermissions;
  Map<Resource, MergedGroupTypePermissionInfo> readEntityPermissions;
  Map<Resource, MergedGroupTypePermissionInfo> readAttrPermissions;
  Map<Resource, MergedGroupTypePermissionInfo> readTsPermissions;

  MergedUserPermissions.fromJson(Map<String, dynamic> json)
      : genericPermissions = (json['genericPermissions'] as Map).map(
            (key, value) => MapEntry(resourceFromString(key),
                (value as List).map((e) => operationFromString(e)).toSet())),
        groupPermissions = (json['groupPermissions'] as Map).map((key, value) =>
            MapEntry(key, MergedGroupPermissionInfo.fromJson(value))),
        readGroupPermissions = (json['readGroupPermissions'] as Map).map(
            (key, value) => MapEntry(entityTypeFromString(key),
                MergedGroupTypePermissionInfo.fromJson(value))),
        readEntityPermissions = (json['readEntityPermissions'] as Map).map(
            (key, value) => MapEntry(resourceFromString(key),
                MergedGroupTypePermissionInfo.fromJson(value))),
        readAttrPermissions = (json['readAttrPermissions'] as Map).map(
            (key, value) => MapEntry(resourceFromString(key),
                MergedGroupTypePermissionInfo.fromJson(value))),
        readTsPermissions = (json['readTsPermissions'] as Map).map(
            (key, value) => MapEntry(resourceFromString(key),
                MergedGroupTypePermissionInfo.fromJson(value)));

  @override
  String toString() {
    return 'MergedUserPermissions{genericPermissions: $genericPermissions, groupPermissions: $groupPermissions, readGroupPermissions: $readGroupPermissions, '
        'readEntityPermissions: $readEntityPermissions, readAttrPermissions: $readAttrPermissions, readTsPermissions: $readTsPermissions}';
  }
}

class AllowedPermissionsInfo {
  Map<Resource, Set<Operation>> operationsByResource;
  Set<Operation> allowedForGroupRoleOperations;
  Set<Operation> allowedForGroupOwnerOnlyOperations;
  Set<Operation> allowedForGroupOwnerOnlyGroupOperations;
  Set<Resource> allowedResources;
  MergedUserPermissions userPermissions;
  EntityId userOwnerId;

  AllowedPermissionsInfo.fromJson(Map<String, dynamic> json)
      : operationsByResource = (json['operationsByResource'] as Map).map(
            (key, value) => MapEntry(resourceFromString(key),
                (value as List).map((e) => operationFromString(e)).toSet())),
        allowedForGroupRoleOperations =
            (json['allowedForGroupRoleOperations'] as List)
                .map((e) => operationFromString(e))
                .toSet(),
        allowedForGroupOwnerOnlyOperations =
            (json['allowedForGroupOwnerOnlyOperations'] as List)
                .map((e) => operationFromString(e))
                .toSet(),
        allowedForGroupOwnerOnlyGroupOperations =
            (json['allowedForGroupOwnerOnlyGroupOperations'] as List)
                .map((e) => operationFromString(e))
                .toSet(),
        allowedResources = (json['allowedResources'] as List)
            .map((e) => resourceFromString(e))
            .toSet(),
        userPermissions =
            MergedUserPermissions.fromJson(json['userPermissions']),
        userOwnerId = EntityId.fromJson(json['userOwnerId']);

  @override
  String toString() {
    return 'AllowedPermissionsInfo{operationsByResource: $operationsByResource, allowedForGroupRoleOperations: $allowedForGroupRoleOperations, '
        'allowedForGroupOwnerOnlyOperations: $allowedForGroupOwnerOnlyOperations, allowedForGroupOwnerOnlyGroupOperations: $allowedForGroupOwnerOnlyGroupOperations, '
        'allowedResources: $allowedResources, userPermissions: $userPermissions, userOwnerId: $userOwnerId}';
  }

  bool hasReadGroupsPermission(EntityType entityType) {
    var groupTypePermissionInfo =
        userPermissions.readGroupPermissions[entityType];
    return groupTypePermissionInfo != null &&
        (groupTypePermissionInfo.hasGenericRead ||
            groupTypePermissionInfo.entityGroupIds.isNotEmpty);
  }

  bool hasReadGenericPermission(Resource resource) {
    return hasGenericPermission(resource, Operation.READ);
  }

  bool hasGenericPermission(Resource resource, Operation operation) {
    return _hasGenericResourcePermission(resource, operation) ||
        _hasGenericAllPermission(operation);
  }

  bool hasGenericEntityGroupTypePermission(
      Operation operation, EntityType groupType) {
    var resource = groupResourceByGroupType[groupType];
    return resource != null && hasGenericPermission(resource, operation);
  }

  bool hasGenericEntityGroupPermission(
      Operation operation, EntityGroup entityGroup) {
    return hasGenericEntityGroupTypePermission(operation, entityGroup.type);
  }

  bool hasEntityGroupPermission(
      Operation operation, EntityGroupInfo entityGroup) {
    return _checkEntityGroupPermission(operation, entityGroup, true);
  }

  bool hasGroupEntityPermission(
      Operation operation, EntityGroupInfo entityGroup) {
    return _checkEntityGroupPermission(operation, entityGroup, false);
  }

  bool isDirectlyOwnedGroup(EntityGroupInfo entityGroup) {
    if (entityGroup.ownerId != null) {
      return _idsEqual(userOwnerId, entityGroup.ownerId!);
    } else {
      return false;
    }
  }

  bool isOwnedGroup(EntityGroupInfo entityGroup) {
    return _isCurrentUserOwner(entityGroup);
  }

  bool isDirectOwner(EntityId ownerId) {
    return _idsEqual(userOwnerId, ownerId);
  }

  bool _hasGenericAllPermission(Operation operation) {
    var operations = userPermissions.genericPermissions[Resource.ALL];
    return operations != null && _checkOperation(operations, operation);
  }

  bool _hasGenericResourcePermission(Resource resource, Operation operation) {
    var operations = userPermissions.genericPermissions[resource];
    return operations != null && _checkOperation(operations, operation);
  }

  bool _checkOperation(Set<Operation> operations, Operation operation) {
    return operations.contains(Operation.ALL) || operations.contains(operation);
  }

  bool _checkEntityGroupPermission(
      Operation operation, EntityGroupInfo entityGroup, bool isGroup) {
    var resource = isGroup
        ? groupResourceByGroupType[entityGroup.type]
        : resourceByEntityType[entityGroup.type];
    if (_isCurrentUserOwner(entityGroup) &&
        hasGenericPermission(resource!, operation)) {
      return true;
    }
    return _hasGroupPermissions(entityGroup, operation, isGroup);
  }

  bool _hasGroupPermissions(
      EntityGroupInfo entityGroup, Operation operation, bool isGroup) {
    if (!allowedForGroupRoleOperations.contains(operation)) {
      return false;
    }
    if (isGroup) {
      if (allowedForGroupOwnerOnlyGroupOperations.contains(operation)) {
        return false;
      }
    } else {
      if (allowedForGroupOwnerOnlyOperations.contains(operation)) {
        if (!_isCurrentUserOwner(entityGroup)) {
          return false;
        }
      }
    }
    var permissionInfo = userPermissions.groupPermissions[entityGroup.id!.id!];
    return permissionInfo != null &&
        _checkOperation(permissionInfo.operations, operation);
  }

  bool _isCurrentUserOwner(EntityGroupInfo entityGroup) {
    var groupOwnerIds = entityGroup.ownerIds;
    return _containsId(groupOwnerIds, userOwnerId);
  }

  bool _containsId(Iterable<EntityId> idsIterable, EntityId id) {
    for (var arrayId in idsIterable) {
      if (_idsEqual(arrayId, id)) {
        return true;
      }
    }
    return false;
  }

  bool _idsEqual(EntityId id1, EntityId id2) {
    return id1.id == id2.id && id1.entityType == id2.entityType;
  }
}
