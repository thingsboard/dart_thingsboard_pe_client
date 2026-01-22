
import 'package:thingsboard_pe_client/thingsboard_client.dart';

class EntityCountQuery {
  EntityFilter entityFilter;
  List<KeyFilter>? keyFilters;

  EntityCountQuery({required this.entityFilter, this.keyFilters});

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['entityFilter'] = entityFilter.toJson();
    json['keyFilters'] =
        keyFilters != null ? keyFilters!.map((e) => e.toJson()).toList() : [];
    return json;
  }

  @override
  String toString() {
    return 'EntityCountQuery{${entityCountQueryString()}}';
  }

  String entityCountQueryString([String? toStringBody]) {
    return 'entityFilter: $entityFilter, keyFilters: $keyFilters${toStringBody != null ? ', $toStringBody' : ''}';
  }
}
