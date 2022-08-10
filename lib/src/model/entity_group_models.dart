import './exportable_entity.dart';
import './id/ids.dart';
import 'additional_info_based.dart';
import 'entity_type_models.dart';
import 'has_name.dart';
import 'has_owner_id.dart';
import 'id/has_id.dart';

class EntityGroup extends AdditionalInfoBased<EntityGroupId>
    with ExportableNoTenantIdEntity<EntityGroupId> implements HasName, HasOwnerId {
  static const String GROUP_ALL_NAME = 'All';

  static const String GROUP_EDGE_ALL_STARTS_WITH = '[Edge]';
  static const String GROUP_EDGE_ALL_ENDS_WITH = 'All';

  String name;
  EntityType type;
  EntityId? ownerId;
  Map<String, dynamic>? configuration;
  EntityGroupId? externalId;

  EntityGroup(this.name, this.type);

  EntityGroup.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = entityTypeFromString(json['type']),
        ownerId = EntityId.fromJson(json['ownerId']),
        configuration = json['configuration'],
        externalId = json['externalId'] != null
            ? EntityGroupId.fromJson(json['externalId'])
            : null,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['name'] = name;
    json['type'] = type.toShortString();
    if (ownerId != null) {
      json['ownerId'] = ownerId!.toJson();
    }
    if (configuration != null) {
      json['configuration'] = configuration;
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
  EntityId? getOwnerId() {
    return ownerId;
  }

  @override
  void setOwnerId(EntityId entityId) {
    ownerId = entityId;
  }

  bool isGroupAll() {
    return GROUP_ALL_NAME == name;
  }

  bool isEdgeGroupAll() {
    return name.startsWith(GROUP_EDGE_ALL_STARTS_WITH) &&
        name.endsWith(GROUP_EDGE_ALL_ENDS_WITH);
  }

  @override
  EntityGroupId? getExternalId() {
    return externalId;
  }

  @override
  void setExternalId(EntityGroupId? externalId) {
    this.externalId = externalId;
  }

  @override
  String toString() {
    return 'EntityGroup{${entityGroupString()}}';
  }

  String entityGroupString([String? toStringBody]) {
    return '${additionalInfoBasedString('name: $name, type: $type, ownerId: $ownerId, configuration: $configuration, externalId: $externalId${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class EntityGroupInfo extends EntityGroup {
  Set<EntityId> ownerIds;

  EntityGroupInfo.fromJson(Map<String, dynamic> json)
      : ownerIds = (json['ownerIds'] as List<dynamic>)
            .map((e) => EntityId.fromJson(e))
            .toSet(),
        super.fromJson(json);

  @override
  String toString() {
    return 'EntityGroup{${entityGroupString('ownerIds: $ownerIds')}}';
  }
}

class ShortEntityView implements HasId<EntityId>, HasName {
  late EntityId id;
  late Map<String, dynamic> properties;

  ShortEntityView.fromJson(Map<String, dynamic> json) {
    var data = Map.of(json);
    id = EntityId.fromJson(data.remove('id'));
    properties = data;
  }

  @override
  EntityId? getId() {
    return id;
  }

  @override
  String getName() {
    return properties['name'];
  }

  @override
  String toString() {
    return 'ShortEntityView{id: $id, properties: $properties}';
  }
}

class ShareGroupRequest {
  final EntityId ownerId;
  final bool isAllUserGroup;
  final EntityGroupId? userGroupId;
  final bool readElseWrite;
  final List<RoleId>? roleIds;

  ShareGroupRequest(
      {required this.ownerId,
      required this.isAllUserGroup,
      this.userGroupId,
      required this.readElseWrite,
      this.roleIds});

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'ownerId': ownerId.toJson(),
      'isAllUserGroup': isAllUserGroup,
      'readElseWrite': readElseWrite
    };
    if (userGroupId != null) {
      json['userGroupId'] = userGroupId!.toJson();
    }
    if (roleIds != null) {
      json['roleIds'] = roleIds!.map((e) => e.toJson()).toList();
    }
    return json;
  }
}
