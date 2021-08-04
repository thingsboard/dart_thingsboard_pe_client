import '../entity_type_models.dart';
import 'entity_id.dart';

class GroupPermissionId extends EntityId {
  GroupPermissionId(String id) : super(EntityType.GROUP_PERMISSION, id);

  @override
  factory GroupPermissionId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as GroupPermissionId;
  }

  @override
  String toString() {
    return 'GroupPermissionId {id: $id}';
  }
}
