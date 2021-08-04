import 'entity_type_models.dart';
import 'group_entity.dart';
import 'id/has_uuid.dart';
import 'relation_models.dart';
import 'id/customer_id.dart';
import 'id/entity_id.dart';
import 'id/entity_view_id.dart';
import 'additional_info_based.dart';
import 'id/tenant_id.dart';

class AttributesEntityView {
  List<String> cs;
  List<String> ss;
  List<String> sh;

  AttributesEntityView()
      : cs = [],
        ss = [],
        sh = [];

  AttributesEntityView.fromJson(Map<String, dynamic> json)
      : cs = json['cs'],
        ss = json['ss'],
        sh = json['sh'];

  Map<String, dynamic> toJson() => {'cs': cs, 'ss': ss, 'sh': sh};

  @override
  String toString() {
    return 'AttributesEntityView{cs: $cs, ss: $ss, sh: $sh}';
  }
}

class TelemetryEntityView {
  List<String> timeseries;
  AttributesEntityView attributes;

  TelemetryEntityView()
      : timeseries = [],
        attributes = AttributesEntityView();

  TelemetryEntityView.fromJson(Map<String, dynamic> json)
      : timeseries = json['timeseries'],
        attributes = AttributesEntityView.fromJson(json['attributes']);

  Map<String, dynamic> toJson() =>
      {'timeseries': timeseries, 'attributes': attributes.toJson()};

  @override
  String toString() {
    return 'TelemetryEntityView{timeseries: $timeseries, attributes: $attributes}';
  }
}

class EntityView extends AdditionalInfoBased<EntityViewId>
    implements GroupEntity<EntityViewId> {
  TenantId? tenantId;
  CustomerId? customerId;
  EntityId entityId;
  String name;
  String type;
  TelemetryEntityView keys;
  int? startTimeMs;
  int? endTimeMs;

  EntityView(
      {required this.entityId,
      required this.name,
      required this.type,
      required this.keys,
      this.startTimeMs,
      this.endTimeMs});

  EntityView.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        entityId = EntityId.fromJson(json['entityId']),
        name = json['name'],
        type = json['type'],
        keys = TelemetryEntityView.fromJson(json['keys']),
        startTimeMs = json['startTimeMs'],
        endTimeMs = json['endTimeMs'],
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
    json['entityId'] = entityId.toJson();
    json['name'] = name;
    json['type'] = type;
    json['keys'] = keys.toJson();
    if (startTimeMs != null) {
      json['startTimeMs'] = startTimeMs;
    }
    if (endTimeMs != null) {
      json['endTimeMs'] = endTimeMs;
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
    return EntityType.ENTITY_VIEW;
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
    return 'EntityView{${entityViewString()}}';
  }

  String entityViewString([String? toStringBody]) {
    return '${additionalInfoBasedString('tenantId: $tenantId, customerId: $customerId, entityId: $entityId, name: $name, type: $type, '
        'keys: $keys, startTimeMs: $startTimeMs, endTimeMs: $endTimeMs${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class EntityViewSearchQuery extends EntitySearchQuery {
  List<String> entityViewTypes;

  EntityViewSearchQuery(
      {required RelationsSearchParameters parameters,
      required this.entityViewTypes,
      String? relationType})
      : super(parameters: parameters, relationType: relationType);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['entityViewTypes'] = entityViewTypes;
    return json;
  }

  @override
  String toString() {
    return 'EntityViewSearchQuery{${entitySearchQueryString('entityViewTypes: $entityViewTypes')}}';
  }
}
