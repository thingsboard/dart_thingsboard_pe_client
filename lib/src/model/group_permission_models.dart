import 'entity_type_models.dart';
import 'id/entity_group_id.dart';
import 'id/entity_id.dart';
import 'id/role_id.dart';
import 'id/tenant_id.dart';
import 'base_data.dart';
import 'has_name.dart';
import 'id/group_permission_id.dart';
import 'tenant_entity.dart';
import 'role_models.dart';

class GroupPermission extends BaseData<GroupPermissionId>
    implements HasName, TenantEntity {
  TenantId? tenantId;
  EntityGroupId userGroupId;
  RoleId roleId;
  EntityGroupId? entityGroupId;
  EntityType? entityGroupType;
  bool isPublic;

  GroupPermission(
      {required this.userGroupId,
      required this.roleId,
      this.isPublic = false,
      this.entityGroupId,
      this.entityGroupType});

  GroupPermission.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        userGroupId = EntityGroupId.fromJson(json['userGroupId']),
        roleId = RoleId.fromJson(json['roleId']),
        entityGroupId = json['entityGroupId'] != null
            ? EntityGroupId.fromJson(json['entityGroupId'])
            : null,
        entityGroupType = json['entityGroupType'] != null
            ? entityTypeFromString(json['entityGroupType'])
            : null,
        isPublic = json['isPublic'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    json['userGroupId'] = userGroupId.toJson();
    json['roleId'] = roleId.toJson();
    if (entityGroupId != null) {
      json['entityGroupId'] = entityGroupId!.toJson();
    }
    if (entityGroupType != null) {
      json['entityGroupType'] = entityGroupType!.toShortString();
    }
    json['isPublic'] = isPublic;
    return json;
  }

  @override
  TenantId? getTenantId() {
    return tenantId;
  }

  @override
  String getName() {
    if (entityGroupId != null && entityGroupType != null) {
      return 'GROUP_[$userGroupId]_[$roleId]_[$entityGroupId]_[${entityGroupType!.toShortString()}]';
    } else {
      return 'GENERIC_[$userGroupId]_[$roleId]';
    }
  }

  @override
  EntityType getEntityType() {
    return EntityType.GROUP_PERMISSION;
  }

  @override
  String toString() {
    return 'GroupPermission{${groupPermissionString()}}';
  }

  String groupPermissionString([String? toStringBody]) {
    return '${baseDataString('tenantId: $tenantId, userGroupId: $userGroupId, roleId: $roleId, entityGroupId: $entityGroupId, entityGroupType: $entityGroupType, '
        'isPublic: $isPublic${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class GroupPermissionInfo extends GroupPermission {
  Role role;
  String? entityGroupName;
  EntityId? entityGroupOwnerId;
  String? entityGroupOwnerName;
  String userGroupName;
  EntityId userGroupOwnerId;
  String userGroupOwnerName;
  bool readOnly;

  GroupPermissionInfo.fromJson(Map<String, dynamic> json)
      : role = Role.fromJson(json['role']),
        entityGroupName = json['entityGroupName'],
        entityGroupOwnerId = json['entityGroupOwnerId'] != null
            ? EntityId.fromJson(json['entityGroupOwnerId'])
            : null,
        entityGroupOwnerName = json['entityGroupOwnerName'],
        userGroupName = json['userGroupName'],
        userGroupOwnerId = EntityId.fromJson(json['userGroupOwnerId']),
        userGroupOwnerName = json['userGroupOwnerName'],
        readOnly = json['readOnly'],
        super.fromJson(json);

  @override
  String toString() {
    return 'GroupPermissionInfo{${groupPermissionString('role: $role, entityGroupName: $entityGroupName, entityGroupOwnerId: $entityGroupOwnerId, '
        'entityGroupOwnerName: $entityGroupOwnerName, userGroupName: $userGroupName, userGroupOwnerId: $userGroupOwnerId, userGroupOwnerName: $userGroupOwnerName, readOnly: $readOnly')}';
  }
}
