
import 'package:thingsboard_pe_client/thingsboard_client.dart';

abstract class AbstractDataQuery<T extends EntityDataPageLink> extends EntityCountQuery {
  T pageLink;
  List<EntityKey>? entityFields;
  List<EntityKey>? latestValues;

  AbstractDataQuery(
      {required EntityFilter entityFilter,
      List<KeyFilter>? keyFilters,
      required this.pageLink,
      this.entityFields,
      this.latestValues})
      : super(entityFilter: entityFilter, keyFilters: keyFilters);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['pageLink'] = pageLink.toJson();
    json['entityFields'] = entityFields != null
        ? entityFields!.map((e) => e.toJson()).toList()
        : [];
    json['latestValues'] = latestValues != null
        ? latestValues!.map((e) => e.toJson()).toList()
        : [];
    return json;
  }

  @override
  String toString() {
    return 'AbstractDataQuery{${dataQueryString()}}';
  }

  String dataQueryString([String? toStringBody]) {
    return '${entityCountQueryString('pageLink: $pageLink, entityFields: $entityFields, latestValues: $latestValues${toStringBody != null ? ', $toStringBody' : ''}')}';
  }
}
