
import 'package:thingsboard_pe_client/thingsboard_client.dart';

class AlarmData extends AlarmInfo {
  final EntityId entityId;
  final Map<EntityKeyType, Map<String, TsValue>> latest;

  AlarmData.fromJson(Map<String, dynamic> json)
      : entityId = EntityId.fromJson(json['entityId']),
        latest = json['latest'] != null
            ? (json['latest'] as Map<String, dynamic>).map((key, value) =>
                MapEntry(
                    entityKeyTypeFromString(key),
                    (value as Map<String, dynamic>).map((key, value) =>
                        MapEntry(key, TsValue.fromJson(value)))))
            : {},
        super.fromJson(json);

  @override
  String toString() {
    return 'AlarmData{${alarmInfoString('entityId: $entityId, latest: $latest')}}';
  }
}
