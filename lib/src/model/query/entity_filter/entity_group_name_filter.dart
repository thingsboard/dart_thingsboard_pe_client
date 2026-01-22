import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityGroupNameFilter extends EntityFilter {
  EntityType groupType;
  String entityGroupNameFilter;

  EntityGroupNameFilter(
      {required this.groupType, required this.entityGroupNameFilter});

  @override
  EntityFilterType getType() {
    return EntityFilterType.ENTITY_GROUP_NAME;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['groupType'] = groupType.toShortString();
    json['entityGroupNameFilter'] = entityGroupNameFilter;
    return json;
  }

  @override
  String toString() {
    return 'EntityGroupNameFilter{groupType: $groupType, entityGroupNameFilter: $entityGroupNameFilter}';
  }
}
