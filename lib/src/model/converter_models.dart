import 'entity_type_models.dart';
import 'exportable_entity.dart';
import 'id/tenant_id.dart';
import 'event_models.dart';
import 'has_name.dart';
import 'id/converter_id.dart';
import 'additional_info_based.dart';
import 'tenant_entity.dart';

enum ConverterType { UPLINK, DOWNLINK }

ConverterType converterTypeFromString(String value) {
  return ConverterType.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension ConverterTypeToString on ConverterType {
  String toShortString() {
    return toString().split('.').last;
  }
}

class Converter extends AdditionalInfoBased<ConverterId>
    with ExportableEntity<ConverterId>
    implements HasName, TenantEntity {
  TenantId? tenantId;
  String name;
  ConverterType type;
  bool debugMode;
  Map<String, dynamic> configuration;
  ConverterId? externalId;

  Converter(
      {required this.name,
      required this.type,
      this.debugMode = false,
      required this.configuration});

  Converter.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        name = json['name'],
        type = converterTypeFromString(json['type']),
        debugMode = json['debugMode'],
        configuration = json['configuration'],
        externalId = json['externalId'] != null
            ? ConverterId.fromJson(json['externalId'])
            : null,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    json['name'] = name;
    json['type'] = type.toShortString();
    json['debugMode'] = debugMode;
    json['configuration'] = configuration;
    if (externalId != null) {
      json['externalId'] = externalId!.toJson();
    }
    return json;
  }

  @override
  String getName() {
    return name;
  }

  @override
  EntityType getEntityType() {
    return EntityType.CONVERTER;
  }

  @override
  TenantId? getTenantId() {
    return tenantId;
  }

  @override
  void setTenantId(TenantId? tenantId) {
    this.tenantId = tenantId;
  }

  @override
  ConverterId? getExternalId() {
    return externalId;
  }

  @override
  void setExternalId(ConverterId? externalId) {
    this.externalId = externalId;
  }

  @override
  String toString() {
    return 'Converter{tenantId: $tenantId, name: $name, type: $type, debugMode: $debugMode, configuration: $configuration, externalId: $externalId}';
  }
}

class TestUpLinkInputParams {
  Map<String, String> metadata;
  String payload;
  String decoder;

  TestUpLinkInputParams(
      {required this.metadata, required this.payload, required this.decoder});

  Map<String, dynamic> toJson() =>
      {'metadata': metadata, 'payload': payload, 'decoder': decoder};
}

class TestDownLinkInputParams {
  Map<String, String> metadata;
  String msg;
  String msgType;
  Map<String, String> integrationMetadata;
  String encoder;

  TestDownLinkInputParams(
      {required this.metadata,
      required this.msg,
      required this.msgType,
      required this.integrationMetadata,
      required this.encoder});

  Map<String, dynamic> toJson() => {
        'metadata': metadata,
        'msg': msg,
        'msgType': msgType,
        'integrationMetadata': integrationMetadata,
        'encoder': encoder
      };
}

class TestConverterResult {
  String? output;
  String? error;

  TestConverterResult.fromJson(Map<String, dynamic> json)
      : output = json['output'],
        error = json['error'];

  @override
  String toString() {
    return 'TestConverterResult{output: $output, error: $error}';
  }
}

class ConverterDebugInput {
  ContentType inContentType;
  String inContent;
  String inMetadata;
  String inMsgType;
  String inIntegrationMetadata;

  ConverterDebugInput.fromJson(Map<String, dynamic> json)
      : inContentType = contentTypeFromString(json['inContentType']),
        inContent = json['inContent'],
        inMetadata = json['inMetadata'],
        inMsgType = json['inMsgType'],
        inIntegrationMetadata = json['inIntegrationMetadata'];

  @override
  String toString() {
    return 'ConverterDebugInput{inContentType: $inContentType, inContent: $inContent, inMetadata: $inMetadata, inMsgType: $inMsgType, inIntegrationMetadata: $inIntegrationMetadata}';
  }
}
