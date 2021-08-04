import 'id/entity_id.dart';

abstract class HasOwnerId {
  EntityId? getOwnerId();

  void setOwnerId(EntityId entityId);
}
