import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityGroupFilter extends EntityFilter {
  EntityType entityType;
  String entityGroup;

  EntityGroupFilter({required this.entityType, required this.entityGroup});

  @override
  EntityFilterType getType() {
    return EntityFilterType.ENTITY_GROUP;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['entityType'] = entityType.toShortString();
    json['entityGroup'] = entityGroup;
    return json;
  }

  @override
  String toString() {
    return 'EntityGroupFilter{entityType: $entityType, entityGroup: $entityGroup}';
  }
}
