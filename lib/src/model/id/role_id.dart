import '../entity_type_models.dart';
import 'entity_id.dart';

class RoleId extends EntityId {
  RoleId(String id) : super(EntityType.ROLE, id);

  @override
  factory RoleId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as RoleId;
  }

  @override
  String toString() {
    return 'RoleId {id: $id}';
  }
}
