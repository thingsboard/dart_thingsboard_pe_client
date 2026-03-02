import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityGroupListFilter extends EntityFilter {
  EntityType groupType;
  List<String> entityGroupList;

  EntityGroupListFilter(
      {required this.groupType, required this.entityGroupList});

  @override
  EntityFilterType getType() {
    return EntityFilterType.ENTITY_GROUP_LIST;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['groupType'] = groupType.toShortString();
    json['entityGroupList'] = entityGroupList;
    return json;
  }

  @override
  String toString() {
    return 'EntityGroupListFilter{groupType: $groupType, entityGroupList: $entityGroupList}';
  }
}
