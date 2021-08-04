import '../entity_type_models.dart';
import 'entity_id.dart';

class SchedulerEventId extends EntityId {
  SchedulerEventId(String id) : super(EntityType.SCHEDULER_EVENT, id);

  @override
  factory SchedulerEventId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as SchedulerEventId;
  }

  @override
  String toString() {
    return 'SchedulerEventId {id: $id}';
  }
}
