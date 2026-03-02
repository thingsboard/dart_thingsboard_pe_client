import 'package:thingsboard_pe_client/thingsboard_client.dart';

class ApiUsageStateFilter extends EntityFilter {
  CustomerId? customerId;

  ApiUsageStateFilter({this.customerId});

  @override
  EntityFilterType getType() {
    return EntityFilterType.API_USAGE_STATE;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (customerId != null) {
      json['customerId'] = customerId!.toJson();
    }
    return json;
  }

  @override
  String toString() {
    return 'ApiUsageStateFilter{customerId: $customerId}';
  }
}
