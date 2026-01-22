
import 'package:thingsboard_pe_client/thingsboard_client.dart';

abstract class EntityFilter {
  EntityFilterType getType();

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['type'] = getType().toShortString();
    return json;
  }
}
