import 'package:thingsboard_pe_client/thingsboard_client.dart';

class SingleEntityFilter extends EntityFilter {
  EntityId singleEntity;

  SingleEntityFilter({required this.singleEntity});

  @override
  EntityFilterType getType() {
    return EntityFilterType.SINGLE_ENTITY;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['singleEntity'] = singleEntity.toJson();
    return json;
  }

  @override
  String toString() {
    return 'SingleEntityFilter{singleEntity: $singleEntity}';
  }
}
