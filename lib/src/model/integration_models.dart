import 'entity_type_models.dart';
import 'id/tenant_id.dart';
import 'additional_info_based.dart';
import 'has_name.dart';
import 'id/converter_id.dart';
import 'id/integration_id.dart';
import 'tenant_entity.dart';

enum IntegrationType {
  OCEANCONNECT,
  SIGFOX,
  THINGPARK,
  TPE,
  CHIRPSTACK,
  TMOBILE_IOT_CDP,
  HTTP,
  MQTT,
  PUB_SUB,
  AWS_IOT,
  AWS_SQS,
  AWS_KINESIS,
  IBM_WATSON_IOT,
  TTN,
  TTI,
  AZURE_EVENT_HUB,
  OPC_UA,
  CUSTOM,
  UDP,
  TCP,
  KAFKA,
  AZURE_IOT_HUB,
  APACHE_PULSAR,
  RABBITMQ,
  LORIOT,
  COAP
}

IntegrationType integrationTypeFromString(String value) {
  return IntegrationType.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension IntegrationTypeToString on IntegrationType {
  String toShortString() {
    return toString().split('.').last;
  }
}

class Integration extends AdditionalInfoBased<IntegrationId>
    implements HasName, TenantEntity {
  TenantId? tenantId;
  ConverterId defaultConverterId;
  ConverterId? downlinkConverterId;
  String name;
  String routingKey;
  IntegrationType type;
  bool? debugMode;
  bool? enabled;
  bool? remote;
  bool? allowCreateDevicesOrAssets;
  String? secret;
  Map<String, dynamic> configuration;

  Integration(
      {required this.defaultConverterId,
      required this.name,
      required this.routingKey,
      required this.type,
      this.configuration = const {},
      this.downlinkConverterId,
      this.debugMode,
      this.enabled,
      this.remote,
      this.allowCreateDevicesOrAssets,
      this.secret});

  Integration.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        defaultConverterId = ConverterId.fromJson(json['defaultConverterId']),
        downlinkConverterId = json['downlinkConverterId'] != null
            ? ConverterId.fromJson(json['downlinkConverterId'])
            : null,
        name = json['name'],
        routingKey = json['routingKey'],
        type = integrationTypeFromString(json['type']),
        debugMode = json['debugMode'],
        enabled = json['enabled'],
        remote = json['remote'],
        allowCreateDevicesOrAssets = json['allowCreateDevicesOrAssets'],
        secret = json['secret'],
        configuration = json['configuration'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    json['defaultConverterId'] = defaultConverterId.toJson();
    if (downlinkConverterId != null) {
      json['downlinkConverterId'] = downlinkConverterId!.toJson();
    }
    json['name'] = name;
    json['routingKey'] = routingKey;
    json['type'] = type.toShortString();
    if (debugMode != null) {
      json['debugMode'] = debugMode;
    }
    if (enabled != null) {
      json['enabled'] = enabled;
    }
    if (remote != null) {
      json['remote'] = remote;
    }
    if (allowCreateDevicesOrAssets != null) {
      json['allowCreateDevicesOrAssets'] = allowCreateDevicesOrAssets;
    }
    if (secret != null) {
      json['secret'] = secret;
    }
    json['configuration'] = configuration;
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
  EntityType getEntityType() {
    return EntityType.INTEGRATION;
  }

  @override
  String toString() {
    return 'Integration{tenantId: $tenantId, defaultConverterId: $defaultConverterId, downlinkConverterId: $downlinkConverterId, name: $name, '
        'routingKey: $routingKey, type: $type, debugMode: $debugMode, enabled: $enabled, remote: $remote, allowCreateDevicesOrAssets: $allowCreateDevicesOrAssets, '
        'secret: $secret, configuration: $configuration}';
  }
}
