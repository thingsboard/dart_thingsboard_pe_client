import 'entity_type_models.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'group_entity.dart';
import 'relation_models.dart';
import 'additional_info_based.dart';
import 'id/asset_id.dart';
import 'id/customer_id.dart';
import 'id/tenant_id.dart';

class Asset extends AdditionalInfoBased<AssetId>
    implements GroupEntity<AssetId> {
  TenantId? tenantId;
  CustomerId? customerId;
  String name;
  String type;
  String? label;

  Asset(this.name, this.type);

  Asset.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        name = json['name'],
        type = json['type'],
        label = json['label'],
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
    json['type'] = type;
    if (label != null) {
      json['label'] = label;
    }
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
    return EntityType.ASSET;
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
    return 'Asset{${assetString()}}';
  }

  String assetString([String? toStringBody]) {
    return '${additionalInfoBasedString('tenantId: $tenantId, customerId: $customerId, name: $name, type: $type, '
        'label: $label${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class AssetSearchQuery extends EntitySearchQuery {
  List<String> assetTypes;

  AssetSearchQuery(
      {required RelationsSearchParameters parameters,
      required this.assetTypes,
      String? relationType})
      : super(parameters: parameters, relationType: relationType);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['assetTypes'] = assetTypes;
    return json;
  }

  @override
  String toString() {
    return 'AssetSearchQuery{${entitySearchQueryString('assetTypes: $assetTypes')}}';
  }
}
