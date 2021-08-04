import '../entity_type_models.dart';
import 'entity_id.dart';

class EntityGroupId extends EntityId {
  EntityGroupId(String id) : super(EntityType.ENTITY_GROUP, id);

  @override
  factory EntityGroupId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as EntityGroupId;
  }

  @override
  String toString() {
    return 'EntityGroupId {id: $id}';
  }
}
