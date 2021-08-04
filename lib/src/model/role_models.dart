import 'dart:collection';

import 'additional_info_based.dart';
import 'entity_type_models.dart';
import 'has_customer_id.dart';
import 'has_name.dart';
import 'has_owner_id.dart';
import 'id/customer_id.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'id/role_id.dart';
import 'id/tenant_id.dart';
import 'security_models.dart';
import 'tenant_entity.dart';

abstract class RolePermissions {
  RolePermissions();

  factory RolePermissions.fromJson(Map<String, dynamic> json) {
    var roleType = roleTypeFromString(json['type']);
    switch (roleType) {
      case RoleType.GENERIC:
        return GenericRolePermissions.fromJson(json['permissions']);
      case RoleType.GROUP:
        return SpecificRolePermissions.fromJson(json['permissions']);
    }
  }

  dynamic toJson();
}

class GenericRolePermissions extends RolePermissions
    with MapMixin<Resource, List<Operation>> {
  final Map<Resource, List<Operation>> _permissionsMap;

  GenericRolePermissions.fromJson(Map<String, dynamic> json)
      : _permissionsMap = json.map((key, value) => MapEntry(
            resourceFromString(key),
            (value as List<dynamic>)
                .map((e) => operationFromString(e))
                .toList()));

  @override
  Map<String, dynamic> toJson() => _permissionsMap.map((key, value) => MapEntry(
      key.toShortString(), value.map((e) => e.toShortString()).toList()));

  @override
  List<Operation>? operator [](Object? key) => _permissionsMap[key];

  @override
  void operator []=(Resource key, List<Operation> value) {
    _permissionsMap[key] = value;
  }

  @override
  void clear() {
    _permissionsMap.clear();
  }

  @override
  Iterable<Resource> get keys => _permissionsMap.keys;

  @override
  List<Operation>? remove(Object? key) => _permissionsMap.remove(key);
}

class SpecificRolePermissions extends RolePermissions
    with ListMixin<Operation> {
  final List<Operation> _operations;

  SpecificRolePermissions.fromJson(List<dynamic> json)
      : _operations = json.map((e) => operationFromString(e)).toList();

  @override
  List<String> toJson() => _operations.map((e) => e.toShortString()).toList();

  @override
  set length(int newLength) {
    _operations.length = newLength;
  }

  @override
  int get length => _operations.length;

  @override
  Operation operator [](int index) => _operations[index];

  @override
  void operator []=(int index, Operation value) {
    _operations[index] = value;
  }
}

class Role extends AdditionalInfoBased<RoleId>
    implements HasName, TenantEntity, HasCustomerId, HasOwnerId {
  TenantId? tenantId;
  CustomerId? customerId;
  String name;
  RoleType type;
  RolePermissions permissions;

  Role.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        name = json['name'],
        type = roleTypeFromString(json['type']),
        permissions = RolePermissions.fromJson(json),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    if (customerId != null) {
      json['customerId'] = customerId!.toJson();
    }
    json['name'] = name;
    json['type'] = type.toShortString();
    json['permissions'] = permissions.toJson();
    return json;
  }

  @override
  String getName() {
    return name;
  }

  @override
  TenantId? getTenantId() {
    return tenantId;
  }

  @override
  CustomerId? getCustomerId() {
    return customerId;
  }

  @override
  EntityType getEntityType() {
    return EntityType.ROLE;
  }

  @override
  EntityId? getOwnerId() {
    return customerId != null && !customerId!.isNullUid()
        ? customerId
        : tenantId;
  }

  @override
  void setOwnerId(EntityId entityId) {
    if (entityId.entityType == EntityType.CUSTOMER) {
      customerId = CustomerId(entityId.id!);
    } else {
      customerId = CustomerId(nullUuid);
    }
  }

  @override
  String toString() {
    return 'Role{tenantId: $tenantId, customerId: $customerId, name: $name, type: $type, permissions: $permissions}';
  }
}
