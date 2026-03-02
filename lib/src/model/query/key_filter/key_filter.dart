import 'package:thingsboard_pe_client/thingsboard_client.dart';

class KeyFilter {
  EntityKey key;
  EntityKeyValueType valueType;
  KeyFilterPredicate predicate;

  KeyFilter(
      {required this.key, required this.valueType, required this.predicate});

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['key'] = key.toJson();
    json['valueType'] = valueType.toShortString();
    json['predicate'] = predicate.toJson();
    return json;
  }

  @override
  String toString() {
    return 'KeyFilter{key: $key, valueType: $valueType, predicate: $predicate}';
  }
}
