import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

class OwnerService {
  final ThingsboardClient _tbClient;

  factory OwnerService(ThingsboardClient tbClient) {
    return OwnerService._internal(tbClient);
  }

  OwnerService._internal(this._tbClient);

  Future<void> changeOwnerToTenant(String ownerId, EntityId entityId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post(
        '/api/owner/TENANT/$ownerId/${entityId.entityType.toShortString()}/${entityId.id}',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<void> changeOwnerToCustomer(String ownerId, EntityId entityId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.post(
        '/api/owner/CUSTOMER/$ownerId/${entityId.entityType.toShortString()}/${entityId.id}',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }
}
