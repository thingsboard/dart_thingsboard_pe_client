import 'entity_type_models.dart';
import 'group_entity.dart';
import 'id/customer_id.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'id/tenant_id.dart';
import 'contact_based_model.dart';

class Customer extends ContactBased<CustomerId>
    implements GroupEntity<CustomerId> {
  TenantId? tenantId;
  CustomerId? parentCustomerId;
  String title;

  Customer(this.title);

  Customer.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        parentCustomerId = json['parentCustomerId'] != null
            ? CustomerId.fromJson(json['parentCustomerId'])
            : null,
        title = json['title'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    if (parentCustomerId != null) {
      json['parentCustomerId'] = parentCustomerId!.toJson();
    }
    json['title'] = title;
    return json;
  }

  @override
  String getName() {
    return title;
  }

  @override
  TenantId? getTenantId() {
    return tenantId;
  }

  @override
  CustomerId? getCustomerId() {
    return parentCustomerId;
  }

  @override
  EntityType getEntityType() {
    return EntityType.CUSTOMER;
  }

  @override
  EntityId? getOwnerId() {
    return parentCustomerId != null && !parentCustomerId!.isNullUid()
        ? parentCustomerId
        : tenantId;
  }

  @override
  void setOwnerId(EntityId entityId) {
    if (entityId.entityType == EntityType.CUSTOMER) {
      parentCustomerId = CustomerId(entityId.id!);
    } else {
      parentCustomerId = CustomerId(nullUuid);
    }
  }

  bool isSubCustomer() =>
      parentCustomerId != null && !parentCustomerId!.isNullUid();

  @override
  String toString() {
    return 'Customer{${contactBasedString('tenantId: $tenantId, parentCustomerId: $parentCustomerId, title: $title')}}';
  }
}

class ShortCustomerInfo {
  CustomerId customerId;
  String title;
  bool isPublic;

  ShortCustomerInfo.fromJson(Map<String, dynamic> json)
      : customerId = CustomerId.fromJson(json['customerId']),
        title = json['title'],
        isPublic = json['isPublic'] ?? false;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'customerId': customerId.toJson(),
      'title': title,
      'isPublic': isPublic
    };
    return json;
  }

  @override
  String toString() {
    return 'ShortCustomerInfo{customerId: $customerId, title: $title, isPublic: $isPublic}';
  }
}
