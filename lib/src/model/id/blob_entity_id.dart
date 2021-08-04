import '../entity_type_models.dart';
import 'entity_id.dart';

class BlobEntityId extends EntityId {
  BlobEntityId(String id) : super(EntityType.BLOB_ENTITY, id);

  @override
  factory BlobEntityId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as BlobEntityId;
  }

  @override
  String toString() {
    return 'BlobEntityId {id: $id}';
  }
}
