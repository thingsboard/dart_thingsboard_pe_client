import 'entity_type_models.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'group_entity.dart';
import 'dart:math';

import 'entity_models.dart';
import 'exportable_entity.dart';
import 'has_rule_engine_profile.dart';
import 'id/asset_profile_id.dart';
import 'id/dashboard_id.dart';
import 'id/rule_chain_id.dart';
import 'relation_models.dart';
import 'additional_info_based.dart';
import 'base_data.dart';
import 'has_name.dart';
import 'has_tenant_id.dart';
import 'id/asset_id.dart';
import 'id/customer_id.dart';
import 'id/tenant_id.dart';

class AssetProfile extends BaseData<AssetProfileId>
    with
        HasName,
        HasTenantId,
        HasRuleEngineProfile,
        ExportableEntity<AssetProfileId> {
  TenantId? tenantId;
  String name;
  String? description;
  bool? isDefault;
  String? image;
  RuleChainId? defaultRuleChainId;
  DashboardId? defaultDashboardId;
  String? defaultQueueName;
  AssetProfileId? externalId;

  AssetProfile(this.name);

  AssetProfile.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        name = json['name'],
        description = json['description'],
        isDefault = json['default'],
        image = json['image'],
        defaultRuleChainId = json['defaultRuleChainId'] != null
            ? RuleChainId.fromJson(json['defaultRuleChainId'])
            : null,
        defaultDashboardId = json['defaultDashboardId'] != null
            ? DashboardId.fromJson(json['defaultDashboardId'])
            : null,
        defaultQueueName = json['defaultQueueName'],
        externalId = json['externalId'] != null
            ? AssetProfileId.fromJson(json['externalId'])
            : null,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    json['name'] = name;
    if (description != null) {
      json['description'] = description;
    }
    if (isDefault != null) {
      json['default'] = isDefault;
    }
    if (image != null) {
      json['image'] = image;
    }
    if (defaultRuleChainId != null) {
      json['defaultRuleChainId'] = defaultRuleChainId!.toJson();
    }
    if (defaultDashboardId != null) {
      json['defaultDashboardId'] = defaultDashboardId!.toJson();
    }
    if (defaultQueueName != null) {
      json['defaultQueueName'] = defaultQueueName;
    }
    if (externalId != null) {
      json['externalId'] = externalId!.toJson();
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
  void setTenantId(TenantId? tenantId) {
    this.tenantId = tenantId;
  }

  @override
  String? getDefaultQueueName() {
    return defaultQueueName;
  }

  @override
  RuleChainId? getDefaultRuleChainId() {
    return defaultRuleChainId;
  }

  @override
  AssetProfileId? getExternalId() {
    return externalId;
  }

  @override
  void setExternalId(AssetProfileId? externalId) {
    this.externalId = externalId;
  }

  @override
  String toString() {
    return 'AssetProfile{${baseDataString('tenantId: $tenantId, name: $name, description: $description, '
        'isDefault: $isDefault, image: ${image != null ? '[' + image!.substring(0, min(30, image!.length)) + '...]' : 'null'}, '
        'defaultRuleChainId: $defaultRuleChainId, defaultDashboardId: $defaultDashboardId, defaultQueueName: $defaultQueueName, '
        'externalId: $externalId')}}';
  }
}

class AssetProfileInfo extends EntityInfo {
  DashboardId? defaultDashboardId;
  String? image;

  AssetProfileInfo(
      EntityId id, String name, this.image, this.defaultDashboardId)
      : super(id, name);

  AssetProfileInfo.fromJson(Map<String, dynamic> json)
      : defaultDashboardId = json['defaultDashboardId'] != null
            ? DashboardId.fromJson(json['defaultDashboardId'])
            : null,
        image = json['image'],
        super.fromJson(json);

  @override
  String toString() {
    return 'AssetProfileInfo{${entityInfoString('defaultDashboardId: $defaultDashboardId, '
        'image: ${image != null ? '[' + image!.substring(0, min(30, image!.length)) + '...]' : 'null'}')}}';
  }
}

class Asset extends AdditionalInfoBased<AssetId>
    with ExportableEntity<AssetId>
    implements GroupEntity<AssetId> {
  TenantId? tenantId;
  CustomerId? customerId;
  String name;
  String type;
  String? label;
  AssetProfileId? assetProfileId;
  AssetId? externalId;

  Asset(this.name, this.type);

  Asset.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        name = json['name'],
        type = json['type'],
        label = json['label'],
        assetProfileId = AssetProfileId.fromJson(json['assetProfileId']),
        externalId = json['externalId'] != null
            ? AssetId.fromJson(json['externalId'])
            : null,
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
    if (assetProfileId != null) {
      json['assetProfileId'] = assetProfileId!.toJson();
    }
    if (externalId != null) {
      json['externalId'] = externalId!.toJson();
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
  void setTenantId(TenantId? tenantId) {
    this.tenantId = tenantId;
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
  AssetId? getExternalId() {
    return externalId;
  }

  @override
  void setExternalId(AssetId? externalId) {
    this.externalId = externalId;
  }

  @override
  String toString() {
    return 'Asset{${assetString()}}';
  }

  String assetString([String? toStringBody]) {
    return '${additionalInfoBasedString('tenantId: $tenantId, customerId: $customerId, name: $name, type: $type, '
        'label: $label, assetProfileId: $assetProfileId, externalId: $externalId${toStringBody != null ? ', ' + toStringBody : ''}')}';
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
