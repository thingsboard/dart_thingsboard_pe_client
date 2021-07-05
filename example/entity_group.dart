import 'package:thingsboard_pe_client/thingsboard_client.dart';

const thingsBoardApiEndpoint = 'http://localhost:8080';
const username = 'tenant@thingsboard.org';
const password = 'tenant';

late ThingsboardClient tbClient;

void main() async {
  try {
    tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    await tbClient.login(LoginRequest(username, password));

    await fetchEntityGroupsExample();
    await fetchEntityGroupEntitiesExample();
    await getOwnersExample();

    await tbClient.logout(requestConfig: RequestConfig(ignoreLoading: true, ignoreErrors: true));

  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}

Future<void> fetchEntityGroupsExample() async {
  print('**********************************************************************');
  print('*                 FETCH ENTITY GROUPS EXAMPLE                        *');
  print('**********************************************************************');

  for (var groupType in [EntityType.DEVICE, EntityType.ASSET, EntityType.ENTITY_VIEW,
        EntityType.DASHBOARD, EntityType.CUSTOMER, EntityType.USER, EntityType.EDGE]) {
    var entityGroups = await tbClient.getEntityGroupService().getEntityGroupsByType(groupType);
    print('found ${groupType.toShortString()} groups: $entityGroups');
  }

  print('**********************************************************************');
}

Future<void> fetchEntityGroupEntitiesExample() async {
  print('**********************************************************************');
  print('*             FETCH ENTITY GROUP ENTITIES EXAMPLE                    *');
  print('**********************************************************************');

  var deviceGroupAll = await tbClient.getEntityGroupService().getEntityGroupAllByOwnerAndType(TenantId(tbClient.getAuthUser()!.tenantId), EntityType.DEVICE);
  print('found device group all: $deviceGroupAll');

  var pageLink = PageLink(10);
  PageData<ShortEntityView> deviceEntities;
  do {
    deviceEntities = await tbClient.getEntityGroupService().getEntities(deviceGroupAll!.id!.id!, pageLink);
    print('Device group all short entity views: $deviceEntities');
    pageLink = pageLink.nextPageLink();
  } while(deviceEntities.hasNext);

  pageLink = PageLink(10);
  PageData<Device> devices;
  do {
    devices = await tbClient.getDeviceService().getDevicesByEntityGroupId(deviceGroupAll.id!.id!, pageLink);
    print('Device group all devices: $devices');
    pageLink = pageLink.nextPageLink();
  } while(devices.hasNext);

  print('**********************************************************************');
}

Future<void> getOwnersExample() async {
  print('**********************************************************************');
  print('*                         GET OWNERS EXAMPLE                         *');
  print('**********************************************************************');

  var pageLink = PageLink(10);
  PageData<ContactBased> owners;
  do {
    owners = await tbClient.getEntityGroupService().getOwners(pageLink);
    print('owners: $owners');
    pageLink = pageLink.nextPageLink();
  } while(owners.hasNext);
  print('**********************************************************************');

  print('**********************************************************************');
}
