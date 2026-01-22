import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityNameFilter extends EntityFilter {
  EntityType entityType;
  String entityNameFilter;

  EntityNameFilter({required this.entityType, required this.entityNameFilter});

  @override
  EntityFilterType getType() {
    return EntityFilterType.ENTITY_NAME;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['entityType'] = entityType.toShortString();
    json['entityNameFilter'] = entityNameFilter;
    return json;
  }

  @override
  String toString() {
    return 'EntityNameFilter{entityType: $entityType, entityNameFilter: $entityNameFilter}';
  }
}
