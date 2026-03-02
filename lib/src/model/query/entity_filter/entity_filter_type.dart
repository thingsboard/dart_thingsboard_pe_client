enum EntityFilterType {
  SINGLE_ENTITY,
  ENTITY_LIST,
  ENTITY_NAME,
  ENTITY_TYPE,
  ASSET_TYPE,
  DEVICE_TYPE,
  ENTITY_VIEW_TYPE,
  EDGE_TYPE,
  RELATIONS_QUERY,
  ASSET_SEARCH_QUERY,
  DEVICE_SEARCH_QUERY,
  ENTITY_VIEW_SEARCH_QUERY,
  EDGE_SEARCH_QUERY,
  API_USAGE_STATE,
  ENTITY_GROUP,
  ENTITY_GROUP_LIST,
  ENTITY_GROUP_NAME,
  ENTITIES_BY_GROUP_NAME,
  STATE_ENTITY_OWNER,
}

const Map<EntityFilterType, String> entityFilterTypeToStringMap = {
  EntityFilterType.SINGLE_ENTITY: 'singleEntity',
  EntityFilterType.ENTITY_LIST: 'entityList',
  EntityFilterType.ENTITY_NAME: 'entityName',
  EntityFilterType.ENTITY_TYPE: 'entityType',
  EntityFilterType.ASSET_TYPE: 'assetType',
  EntityFilterType.DEVICE_TYPE: 'deviceType',
  EntityFilterType.ENTITY_VIEW_TYPE: 'entityViewType',
  EntityFilterType.EDGE_TYPE: 'edgeType',
  EntityFilterType.RELATIONS_QUERY: 'relationsQuery',
  EntityFilterType.ASSET_SEARCH_QUERY: 'assetSearchQuery',
  EntityFilterType.DEVICE_SEARCH_QUERY: 'deviceSearchQuery',
  EntityFilterType.ENTITY_VIEW_SEARCH_QUERY: 'entityViewSearchQuery',
  EntityFilterType.EDGE_SEARCH_QUERY: 'edgeSearchQuery',
  EntityFilterType.API_USAGE_STATE: 'apiUsageState',
  EntityFilterType.ENTITY_GROUP: 'entityGroup',
  EntityFilterType.ENTITY_GROUP_LIST: 'entityGroupList',
  EntityFilterType.ENTITY_GROUP_NAME: 'entityGroupName',
  EntityFilterType.ENTITIES_BY_GROUP_NAME: 'entitiesByGroupName',
  EntityFilterType.STATE_ENTITY_OWNER: 'stateEntityOwner',
};

Map<String, EntityFilterType> stringToEntityFilterTypeMap =
    entityFilterTypeToStringMap.map((key, value) => MapEntry(value, key));

EntityFilterType entityFilterTypeFromString(String value) {
  return stringToEntityFilterTypeMap[value]!;
}

extension EntityFilterTypeToString on EntityFilterType {
  String toShortString() {
    return entityFilterTypeToStringMap[this]!;
  }
}