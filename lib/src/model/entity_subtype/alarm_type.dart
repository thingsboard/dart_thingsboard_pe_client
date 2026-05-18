
import 'package:thingsboard_pe_client/thingsboard_client.dart';

class AlarmType extends EntitySubType {
  AlarmType(super.entityType, super.tenantId, super.type);

  @override
  factory AlarmType.fromJson(Map<String, dynamic> json) {
    final entitySubType = EntitySubType.fromJson(json);

    return AlarmType(
      entitySubType.entityType,
      entitySubType.tenantId,
      entitySubType.type,
    );
  }
}
