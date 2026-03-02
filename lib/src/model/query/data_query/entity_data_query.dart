
import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityDataQuery extends AbstractDataQuery<EntityDataPageLink> {
  EntityDataQuery(
      {required EntityFilter entityFilter,
      List<KeyFilter>? keyFilters,
      required EntityDataPageLink pageLink,
      List<EntityKey>? entityFields,
      List<EntityKey>? latestValues})
      : super(
            entityFilter: entityFilter,
            keyFilters: keyFilters,
            pageLink: pageLink,
            entityFields: entityFields,
            latestValues: latestValues);

  EntityDataQuery next() {
    return EntityDataQuery(
        entityFilter: entityFilter,
        pageLink: pageLink.nextPageLink(),
        keyFilters: keyFilters,
        entityFields: entityFields,
        latestValues: latestValues);
  }

  @override
  String toString() {
    return 'EntityDataQuery{${dataQueryString()}}';
  }
}
