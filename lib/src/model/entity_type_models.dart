import 'id/tenant_id.dart';

enum EntityType {
  TENANT,
  TENANT_PROFILE,
  CUSTOMER,
  USER,
  DASHBOARD,
  ASSET,
  DEVICE,
  DEVICE_PROFILE,
  ALARM,
  ENTITY_GROUP,
  CONVERTER,
  INTEGRATION,
  RULE_CHAIN,
  RULE_NODE,
  SCHEDULER_EVENT,
  BLOB_ENTITY,
  EDGE,
  ENTITY_VIEW,
  WIDGETS_BUNDLE,
  WIDGET_TYPE,
  ROLE,
  GROUP_PERMISSION,
  API_USAGE_STATE,
  TB_RESOURCE,
  OTA_PACKAGE,
  RPC
}

EntityType entityTypeFromString(String value) {
  return EntityType.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension EntityTypeToString on EntityType {
  String toShortString() {
    return toString().split('.').last;
  }
}

class EntitySubtype {
  TenantId tenantId;
  EntityType entityType;
  String type;

  EntitySubtype.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        entityType = entityTypeFromString(json['entityType']),
        type = json['type'];

  @override
  String toString() {
    return 'EntitySubtype{tenantId: $tenantId, entityType: $entityType, type: $type}';
  }
}
