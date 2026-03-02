import 'package:thingsboard_pe_client/thingsboard_client.dart';

class StateEntityOwnerFilter extends EntityFilter {
  EntityId singleEntity;

  StateEntityOwnerFilter({required this.singleEntity});

  @override
  EntityFilterType getType() {
    return EntityFilterType.STATE_ENTITY_OWNER;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['singleEntity'] = singleEntity.toJson();
    return json;
  }

  @override
  String toString() {
    return 'StateEntityOwnerFilter{singleEntity: $singleEntity}';
  }
}