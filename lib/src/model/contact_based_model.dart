import 'customer_models.dart';
import 'entity_type_models.dart';
import 'tenant_models.dart';

import 'additional_info_based.dart';
import 'has_name.dart';
import 'id/has_uuid.dart';
import 'id/ids.dart';

abstract class ContactBased<T extends HasUuid> extends AdditionalInfoBased<T>
    with HasName {
  String? country;
  String? state;
  String? city;
  String? address;
  String? address2;
  String? zip;
  String? phone;
  String? email;

  ContactBased();

  factory ContactBased.contactBasedFromJson(Map<String, dynamic> json) {
    var id = EntityId.fromJson(json['id']);
    if (id.entityType == EntityType.TENANT) {
      return Tenant.fromJson(json) as ContactBased<T>;
    } else {
      return Customer.fromJson(json) as ContactBased<T>;
    }
  }

  ContactBased.fromJson(Map<String, dynamic> json)
      : country = json['country'],
        state = json['state'],
        city = json['city'],
        address = json['address'],
        address2 = json['address2'],
        zip = json['zip'],
        phone = json['phone'],
        email = json['email'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (country != null) {
      json['country'] = country;
    }
    if (state != null) {
      json['state'] = state;
    }
    if (city != null) {
      json['city'] = city;
    }
    if (address != null) {
      json['address'] = address;
    }
    if (address2 != null) {
      json['address2'] = address2;
    }
    if (zip != null) {
      json['zip'] = zip;
    }
    if (phone != null) {
      json['phone'] = phone;
    }
    if (email != null) {
      json['email'] = email;
    }
    return json;
  }

  @override
  String toString() {
    return 'ContactBased{${contactBasedString()}}';
  }

  String contactBasedString([String? toStringBody]) {
    return '${additionalInfoBasedString('${toStringBody != null ? toStringBody + ', ' : ''}country: $country, state: $state, city: $city, address: $address, address2: $address2, zip: $zip, phone: $phone, email: $email')}';
  }
}
