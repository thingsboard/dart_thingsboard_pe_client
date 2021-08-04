import '../entity_type_models.dart';
import 'entity_id.dart';

class IntegrationId extends EntityId {
  IntegrationId(String id) : super(EntityType.INTEGRATION, id);

  @override
  factory IntegrationId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as IntegrationId;
  }

  @override
  String toString() {
    return 'IntegrationId {id: $id}';
  }
}
