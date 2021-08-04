import '../model/security_models.dart';

import '../http/http_utils.dart';
import '../thingsboard_client_base.dart';

class UserPermissionsService {
  final ThingsboardClient _tbClient;

  factory UserPermissionsService(ThingsboardClient tbClient) {
    return UserPermissionsService._internal(tbClient);
  }

  UserPermissionsService._internal(this._tbClient);

  Future<AllowedPermissionsInfo> getAllowedPermissions(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/permissions/allowedPermissions',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return AllowedPermissionsInfo.fromJson(response.data!);
  }
}
