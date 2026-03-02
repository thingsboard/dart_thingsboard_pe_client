import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntitiesByGroupNameFilter extends EntityFilter {
  EntityType groupType;
  EntityId ownerId;
  String entityGroupNameFilter;

  EntitiesByGroupNameFilter(
      {required this.groupType,
      required this.ownerId,
      required this.entityGroupNameFilter});

  @override
  EntityFilterType getType() {
    return EntityFilterType.ENTITIES_BY_GROUP_NAME;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['groupType'] = groupType.toShortString();
    json['ownerId'] = ownerId.toJson();
    json['entityGroupNameFilter'] = entityGroupNameFilter;
    return json;
  }

  @override
  String toString() {
    return 'EntitiesByGroupNameFilter{groupType: $groupType, ownerId: $ownerId, entityGroupNameFilter: $entityGroupNameFilter}';
  }
}
