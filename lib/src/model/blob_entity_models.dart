import 'id/customer_id.dart';
import 'entity_type_models.dart';
import 'has_name.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'id/tenant_id.dart';
import 'additional_info_based.dart';
import 'has_owner_id.dart';
import 'has_customer_id.dart';
import 'id/blob_entity_id.dart';
import 'tenant_entity.dart';

class BlobEntityInfo extends AdditionalInfoBased<BlobEntityId>
    implements HasName, TenantEntity, HasCustomerId, HasOwnerId {
  TenantId? tenantId;
  CustomerId? customerId;
  String name;
  String type;
  String contentType;

  BlobEntityInfo.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        name = json['name'],
        type = json['type'],
        contentType = json['contentType'],
        super.fromJson(json);

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
    return EntityType.BLOB_ENTITY;
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
    return 'BlobEntityInfo{${blobEntityInfoString()}}';
  }

  String blobEntityInfoString([String? toStringBody]) {
    return '${additionalInfoBasedString('tenantId: $tenantId, customerId: $customerId, name: $name, type: $type, '
        'contentType: $contentType${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class BlobEntityWithCustomerInfo extends BlobEntityInfo {
  String? customerTitle;
  bool? customerIsPublic;

  BlobEntityWithCustomerInfo.fromJson(Map<String, dynamic> json)
      : customerTitle = json['customerTitle'],
        customerIsPublic = json['customerIsPublic'],
        super.fromJson(json);

  @override
  String toString() {
    return 'BlobEntityWithCustomerInfo{${blobEntityInfoString('customerTitle: $customerTitle, customerIsPublic: $customerIsPublic')}}';
  }
}
