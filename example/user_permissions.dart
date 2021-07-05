import 'package:thingsboard_pe_client/thingsboard_client.dart';

const thingsBoardApiEndpoint = 'http://localhost:8080';
const username = 'tenant@thingsboard.org';
const password = 'tenant';

late ThingsboardClient tbClient;

void main() async {
  try {
    tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    await tbClient.login(LoginRequest(username, password));

    await userPermissionsExample();

    await tbClient.logout(requestConfig: RequestConfig(ignoreLoading: true, ignoreErrors: true));

  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}

Future<void> userPermissionsExample() async {
  print('**********************************************************************');
  print('*               USER PERMISSIONS EXAMPLE                             *');
  print('**********************************************************************');

  var allowedUserPermissions = await tbClient.getUserPermissionsService().getAllowedPermissions();

  print('Allowed user permissions: ${allowedUserPermissions.userPermissions}');

  print('Has generic devices read permission: ${allowedUserPermissions.hasGenericPermission(Resource.DEVICE, Operation.READ)}');

  print('**********************************************************************');
}
