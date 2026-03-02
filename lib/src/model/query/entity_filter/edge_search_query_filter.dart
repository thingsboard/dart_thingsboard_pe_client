import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EdgeSearchQueryFilter extends EntitySearchQueryFilter {
  List<String> edgeTypes;

  EdgeSearchQueryFilter(
      {required this.edgeTypes,
      required EntityId rootEntity,
      String? relationType,
      EntitySearchDirection direction = EntitySearchDirection.FROM,
      int maxLevel = 1,
      bool fetchLastLevelOnly = false,
       bool rootStateEntity = false,
      EntityId? defaultStateEntity,
      })
      : super(
        rootStateEntity: rootStateEntity,
        defaultStateEntity: defaultStateEntity,
            rootEntity: rootEntity,
            relationType: relationType,
            direction: direction,
            maxLevel: maxLevel,
            fetchLastLevelOnly: fetchLastLevelOnly);

  @override
  EntityFilterType getType() {
    return EntityFilterType.EDGE_SEARCH_QUERY;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['edgeTypes'] = edgeTypes;
    return json;
  }

  @override
  String toString() {
    return 'EdgeSearchQueryFilter{${entitySearchQueryFilterString('edgeTypes: $edgeTypes')}}';
  }
}
