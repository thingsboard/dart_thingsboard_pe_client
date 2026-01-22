import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityListFilter extends EntityFilter {
  EntityType entityType;
  List<String> entityList;

  EntityListFilter({required this.entityType, required this.entityList});

  @override
  EntityFilterType getType() {
    return EntityFilterType.ENTITY_LIST;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['entityType'] = entityType.toShortString();
    json['entityList'] = entityList;
    return json;
  }

  @override
  String toString() {
    return 'EntityListFilter{entityType: $entityType, entityList: $entityList}';
  }
}
