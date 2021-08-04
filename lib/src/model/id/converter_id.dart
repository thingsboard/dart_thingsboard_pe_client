import '../entity_type_models.dart';
import 'entity_id.dart';

class ConverterId extends EntityId {
  ConverterId(String id) : super(EntityType.CONVERTER, id);

  @override
  factory ConverterId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as ConverterId;
  }

  @override
  String toString() {
    return 'ConverterId {id: $id}';
  }
}
