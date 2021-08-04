import 'id/customer_id.dart';
import 'entity_type_models.dart';
import 'has_name.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'id/scheduler_event_id.dart';
import 'id/tenant_id.dart';
import 'additional_info_based.dart';
import 'has_owner_id.dart';
import 'has_customer_id.dart';
import 'tenant_entity.dart';

enum SchedulerRepeatType { DAILY, WEEKLY, MONTHLY, YEARLY, TIMER }

SchedulerRepeatType schedulerRepeatTypeFromString(String value) {
  return SchedulerRepeatType.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension SchedulerRepeatTypeToString on SchedulerRepeatType {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum SchedulerTimeUnit { HOURS, MINUTES, SECONDS }

SchedulerTimeUnit schedulerTimeUnitFromString(String value) {
  return SchedulerTimeUnit.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension SchedulerTimeUnitToString on SchedulerTimeUnit {
  String toShortString() {
    return toString().split('.').last;
  }
}

class SchedulerRepeat {
  SchedulerRepeatType type;
  int endsOn;
  List<int>? repeatOn;
  int? repeatInterval;
  SchedulerTimeUnit? timeUnit;

  SchedulerRepeat(
      {required this.type,
      required this.endsOn,
      this.repeatOn,
      this.repeatInterval,
      this.timeUnit});

  SchedulerRepeat.fromJson(Map<String, dynamic> json)
      : type = schedulerRepeatTypeFromString(json['type']),
        endsOn = json['endsOn'],
        repeatOn = json['repeatOn'] != null
            ? (json['repeatOn'] as List<dynamic>).map((e) => e as int).toList()
            : null,
        repeatInterval = json['repeatInterval'],
        timeUnit = json['timeUnit'] != null
            ? schedulerTimeUnitFromString(json['timeUnit'])
            : null;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'type': type.toShortString(),
      'endsOn': endsOn
    };
    if (repeatOn != null) {
      json['repeatOn'] = repeatOn;
    }
    if (repeatInterval != null) {
      json['repeatInterval'] = repeatInterval;
    }
    if (timeUnit != null) {
      json['timeUnit'] = timeUnit!.toShortString();
    }
    return json;
  }

  @override
  String toString() {
    return 'SchedulerRepeat{type: $type, endsOn: $endsOn, repeatOn: $repeatOn, repeatInterval: $repeatInterval, timeUnit: $timeUnit}';
  }
}

class SchedulerEventSchedule {
  String? timezone;
  int? startTime;
  SchedulerRepeat? repeat;

  SchedulerEventSchedule({this.timezone, this.startTime, this.repeat});

  SchedulerEventSchedule.fromJson(Map<String, dynamic> json)
      : timezone = json['timezone'],
        startTime = json['startTime'],
        repeat = json['repeat'] != null
            ? SchedulerRepeat.fromJson(json['repeat'])
            : null;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (timezone != null) {
      json['json'] = timezone;
    }
    if (startTime != null) {
      json['startTime'] = startTime;
    }
    if (repeat != null) {
      json['repeat'] = repeat!.toJson();
    }
    return json;
  }

  @override
  String toString() {
    return 'SchedulerEventSchedule{timezone: $timezone, startTime: $startTime, repeat: $repeat}';
  }
}

class SchedulerEventInfo extends AdditionalInfoBased<SchedulerEventId>
    implements HasName, TenantEntity, HasCustomerId, HasOwnerId {
  TenantId? tenantId;
  CustomerId? customerId;
  String name;
  String type;
  SchedulerEventSchedule schedule;

  SchedulerEventInfo(
      {required this.name, required this.type, required this.schedule});

  SchedulerEventInfo.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        name = json['name'],
        type = json['type'],
        schedule = SchedulerEventSchedule.fromJson(json['schedule']),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    if (customerId != null) {
      json['customerId'] = customerId!.toJson();
    }
    json['name'] = name;
    json['type'] = type;
    json['schedule'] = schedule.toJson();
    return json;
  }

  @override
  String getName() {
    return name;
  }

  @override
  TenantId? getTenantId() {
    return tenantId;
  }

  @override
  CustomerId? getCustomerId() {
    return customerId;
  }

  @override
  EntityType getEntityType() {
    return EntityType.SCHEDULER_EVENT;
  }

  @override
  EntityId? getOwnerId() {
    return customerId != null && !customerId!.isNullUid()
        ? customerId
        : tenantId;
  }

  @override
  void setOwnerId(EntityId entityId) {
    if (entityId.entityType == EntityType.CUSTOMER) {
      customerId = CustomerId(entityId.id!);
    } else {
      customerId = CustomerId(nullUuid);
    }
  }

  @override
  String toString() {
    return 'SchedulerEventInfo{${schedulerEventInfoString()}}';
  }

  String schedulerEventInfoString([String? toStringBody]) {
    return '${additionalInfoBasedString('tenantId: $tenantId, customerId: $customerId, name: $name, type: $type, '
        'schedule: $schedule${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class SchedulerEventWithCustomerInfo extends SchedulerEventInfo {
  String? customerTitle;
  bool? customerIsPublic;

  SchedulerEventWithCustomerInfo.fromJson(Map<String, dynamic> json)
      : customerTitle = json['customerTitle'],
        customerIsPublic = json['customerIsPublic'],
        super.fromJson(json);

  @override
  String toString() {
    return 'SchedulerEventWithCustomerInfo{${schedulerEventInfoString('customerTitle: $customerTitle, customerIsPublic: $customerIsPublic')}}';
  }
}

class SchedulerEventConfiguration {
  EntityId? originatorId;
  String? msgType;
  Map<String, dynamic>? msgBody;
  Map<String, dynamic>? metadata;

  SchedulerEventConfiguration(
      {this.originatorId, this.msgType, this.msgBody, this.metadata});

  SchedulerEventConfiguration.fromJson(Map<String, dynamic> json)
      : originatorId = json['originatorId'] != null
            ? EntityId.fromJson(json['originatorId'])
            : null,
        msgType = json['msgType'],
        msgBody = json['msgBody'],
        metadata = json['metadata'];

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (originatorId != null) {
      json['originatorId'] = originatorId!.toJson();
    }
    if (msgType != null) {
      json['msgType'] = msgType;
    }
    if (msgBody != null) {
      json['msgBody'] = msgBody;
    }
    if (metadata != null) {
      json['metadata'] = metadata;
    }
    return json;
  }

  @override
  String toString() {
    return 'SchedulerEventConfiguration{originatorId: $originatorId, msgType: $msgType, msgBody: $msgBody, metadata: $metadata}';
  }
}

class SchedulerEvent extends SchedulerEventInfo {
  SchedulerEventConfiguration configuration;

  SchedulerEvent(
      {required String name,
      required String type,
      required SchedulerEventSchedule schedule,
      required this.configuration})
      : super(name: name, type: type, schedule: schedule);

  SchedulerEvent.fromJson(Map<String, dynamic> json)
      : configuration =
            SchedulerEventConfiguration.fromJson(json['configuration']),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['configuration'] = configuration.toJson();
    return json;
  }

  @override
  String toString() {
    return 'SchedulerEvent{${schedulerEventInfoString('configuration: $configuration')}}';
  }
}
