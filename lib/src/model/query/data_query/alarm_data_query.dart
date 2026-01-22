
import 'package:thingsboard_pe_client/thingsboard_client.dart';

class AlarmDataQuery extends AbstractDataQuery<AlarmDataPageLink> {
  List<EntityKey>? alarmFields;

  AlarmDataQuery(
      {required EntityFilter entityFilter,
      List<KeyFilter>? keyFilters,
      required AlarmDataPageLink pageLink,
      List<EntityKey>? entityFields,
      List<EntityKey>? latestValues,
      this.alarmFields})
      : super(
            entityFilter: entityFilter,
            keyFilters: keyFilters,
            pageLink: pageLink,
            entityFields: entityFields,
            latestValues: latestValues);

  AlarmDataQuery next() {
    return AlarmDataQuery(
        entityFilter: entityFilter,
        pageLink: pageLink.nextPageLink(),
        keyFilters: keyFilters,
        entityFields: entityFields,
        latestValues: latestValues,
        alarmFields: alarmFields);
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (alarmFields != null) {
      json['alarmFields'] = alarmFields!.map((e) => e.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return 'AlarmDataQuery{${dataQueryString('alarmFields: $alarmFields')}}';
  }
}
