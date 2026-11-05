## 5.0.0
- **Deprecated:** `thingsboard_pe_client` is discontinued and replaced by
  [`thingsboard_client`](https://pub.dev/packages/thingsboard_client) (ThingsBoard CE and PE are now one product).
- The package no longer contains any implementation: its main library `thingsboard_pe_client.dart` (and the
  4.2.x main library `thingsboard_client.dart`) only re-export `package:thingsboard_client/thingsboard_client.dart`
  (`thingsboard_client: ^5.0.0`) and are marked `@Deprecated`.
- The REST API is the same OpenAPI-generated API as in 4.4.x (`get*ControllerApi()`, built_value models), apart
  from the breaking changes below. The full migration guide is the "Migrating from `thingsboard_pe_client` 4.4.x"
  entry and the telemetry WebSocket, login and `Authority` entries of the
  [thingsboard_client 5.0.0 CHANGELOG](https://pub.dev/packages/thingsboard_client/changelog#500).
- **BREAKING:** deep imports (`package:thingsboard_pe_client/src/...`) no longer work: `lib/src` was never public
  API, and this package has none. Import `package:thingsboard_client/thingsboard_client.dart` instead, which
  exports the replacement types. The raw generated client `ThingsboardPeClient` (from `src/api.dart`) is the
  generated `ThingsboardClient` of `thingsboard_client`, hidden from its main library as before.
- **BREAKING:** the telemetry WebSocket API (`TelemetrySubscriber`, commands, queries, updates) is exported by the
  main library and works on the generated built_value models instead of ~90 handwritten duplicates:
  - `DeviceId(uuid)` → `DeviceId((b) => b..id = uuid)`;
    `EntityDataQuery(entityFilter: f, pageLink: p)` → `EntityDataQuery((b) => b..entityFilter = f..pageLink = p.toBuilder())`;
    discriminators (`type`, `entityType`, ...) are set automatically and are not passed any more.
  - `AttributeData.value` is a `JsonObject`.
  - `EntityDataUpdate` / `AlarmDataUpdate` are immutable: `withTsOffset(int)` returns a shifted copy.
  - Notifications: `NotificationsUpdate` holds the generated `Notification` with typed `*NotificationInfo`
    subtypes. `PushNotification`, `PushNotificationInfo`, `PushNotificationType`, `PushNotificationStatus` and their
    helpers are removed: use `Notification`, `NotificationType` and `NotificationStatus`.
  - The `KvEntry` family, `RestJsonConverter`, the facade `AlarmQuery` / `AlarmQueryV2` / `AlarmCommentsQuery`,
    `BaseData`, `HasName`, `HasTenantId` and `PushNotificationQuery` are removed; the handwritten `DataType` and
    `AlarmInfo` are replaced by the generated REST models of the same names.
  - Each update is parsed by its command's parser: a custom `WebsocketCmd` subclass must override `updateParser`.
- **BREAKING:** `LoginRequest`, `RefreshTokenRequest` and `LoginResponse` are the generated built_value models,
  exported by the main library: `LoginRequest(userName: u, password: p)` →
  `LoginRequest((b) => b..username = u..password = p)` (`userName` → `username`),
  `RefreshTokenRequest(token)` → `RefreshTokenRequest((b) => b..refreshToken = token)`;
  `LoginResponse.scope` is `Authority?` and `LoginResponse.refreshToken` is nullable. The JSON on the wire is unchanged.
- **BREAKING:** `Authority` is a single type, the generated built_value class; the handwritten `enum Authority` is
  removed; `authorityFromString` and `toShortString` work on the generated class. `AuthUser.authority` is `Authority?` and is `null` for an anonymous user (was
  `Authority.ANONYMOUS`); `authorityFromString` returns `null` for an unknown name instead of throwing; a `switch`
  over `Authority` needs a `default` branch.
- **BREAKING:** `ThingsboardError.errorCode` (the facade `ThingsBoardErrorCode`) now matches the server:
  `subscriptionViolation` is 40 (it was 35, so it was never returned), and `entitiesLimitExceeded` (41) and
  `setupIncomplete` (47) are new; before, codes 40, 41 and 47 decoded as `general`. `tenantTrialExpired` (12) is
  removed, the server never sends it.
- **BREAKING:** `SortOrder` takes the generated `Direction` exported by the main library
  (`SortOrder('name', Direction.ASC)`). The handwritten `Direction` enum and `Direction.toShortString()` are
  removed (use `Direction.name`); `PageLink.toQueryParameters()` output is unchanged.
- **BREAKING:** removed unused API: `nullIfNotFound` and `isSuccessful` (catch the `DioException` instead and
  inspect `(e.error as ThingsboardError).errorCode`), `AuthUser.fromToken`, the top-level `isJwtTokenValid(String?)`
  (use `ThingsboardClient.isJwtTokenValid()`), and `KeyInterceptConfig` (no longer exported by the main library).
- Fixed: `LocalFileStorage.getItem` returns `defaultValue` for an absent key, and `containsKey` waits for the file
  to load, so a key stored by a previous instance is found.
- **BREAKING:** 68 constants in 19 enums are renamed to the plain generator names (wire values are unchanged), e.g.
  `SignUpFieldId.aDDRESS2` → `ADDRESS2`, `EntityType.oAUTH2CLIENT` → `OAUTH2_CLIENT`,
  `DeviceTransportType.lWM2M` → `LWM2M`, `DeviceCredentialsType.x509CERTIFICATE` → `X509_CERTIFICATE`,
  `ThingsboardErrorCode.n10` → `number10`, and `TelemetryObserveStrategy`
  `sINGLELeftParenthesis0RightParenthesisColonOneResourceEqualsOneSingleObserveRequest` → `SINGLE`
  (likewise `COMPOSITE_ALL`, `COMPOSITE_BY_OBJECT`).
- **BREAKING:** `DeviceApiControllerApi` and `ThingsboardClient.getDeviceApiControllerApi()` are removed. The
  device-token HTTP endpoints (`/api/v1/**`) are not part of the ThingsBoard client API spec; devices should use the
  MQTT, CoAP or HTTP device transport directly.
- **BREAKING:** `SolutionControllerApi` (`getSolutionControllerApi()`) and the solution template models
  (`ComplexOperation`, `SolutionInstallResponse`, `SolutionTemplateLevel`, `TenantSolutionTemplateDetails`,
  `TenantSolutionTemplateInfo`, `TenantSolutionTemplateInstructions`) are removed. They came from a 4.4.0 snapshot
  spec and are not part of the ThingsBoard 4.4.0 release.
- **BREAKING** (model fixes from the OpenAPI spec):
  - `AliasEntityId.entityType` is now `String` (was `EntityType`) and `AliasEntityId.id` is now `String?`.
  - `RefreshTokenRequest.refreshToken` is now `String?` (was `JsonObject?`).
  - `ColumnSettings.type` is removed.
  - `Lwm2mControllerApi.saveLwm2mDeviceWithCredentials` now takes `requestBody` as `BuiltMap<String, JsonObject?>`.
- **BREAKING:** minimum Dart SDK is now 3.10.0 (Flutter 3.38+); older SDKs are dropped for security reasons.
- Note for users upgrading from 4.2.x or earlier: 4.4.0 already replaced the handwritten API
  (`getUserService()`, `getDeviceService()`, ...) with the generated one, and that release was breaking.
  This release does not restore the 4.2.x API.
- Migration: see the [README](https://github.com/thingsboard/dart_thingsboard_pe_client#migration).

## 4.4.1

- `Palette.type` and `PaletteSettings.primaryPalette` / `accentPalette` are nullable. The server returns `{type: null}` for a palette left on "Default", which made `getWhiteLabelParams()` and `getLoginWhiteLabelParams()` fail to deserialize (PROD-8931).
- Telemetry WebSocket: `reset()` also clears the reconnect state, so the first subscription after a logout is published when the socket opens. Unsubscribing during a reconnect backoff no longer sends stale commands to the new socket or lets the subscriber count go negative, which closed a socket that still had live subscribers after the idle timeout (PROD-8863).
- A connect timeout or connection error is reported as `Unable to connect`, like a refused connection, on both io and web. The best-effort server version check in `init()` no longer reports its failures through `onError`, so an offline start does not show a connection error.

## 4.4.0

- Initial release targeting ThingsBoard Professional Edition 4.4.0 server.
- **BREAKING** (not marked as such when published): replaces the handwritten 4.2.x API (`getUserService()`,
  `getDeviceService()`, ...) with the generated API classes (`getUserControllerApi()`, ...).
- Published from the [thingsboard-dart-client](https://github.com/thingsboard/thingsboard-dart-client) repository.
- Auto-generated from OpenAPI spec using openapi-generator-cli 7.20.0 (dart-dio template).
- Handwritten runtime facade: JWT authentication with auto-refresh, Completer-gated token refresh, WebSocket telemetry subscriptions, typed ThingsboardError with retry logic.
- 81 API service classes, 949+ model types.
- Supports Flutter mobile (iOS/Android) and Flutter Web. Requires Dart SDK >=3.2.0.
- Token refresh keeps the stored session on transport failures (no network, timeout, 5xx); only an HTTP 401 from the refresh endpoint clears it.
- `init()` restores the stale session when the refresh cannot reach the server, so the next authenticated request retries the refresh instead of the user being logged out. The telemetry WebSocket likewise reconnects instead of logging out when its token refresh cannot reach the server.
- Default 20s connect timeout on every request and a 15s send/receive timeout on the token-refresh call.
- `ThingsboardError.isUnauthorized` identifies a rejected-credentials error regardless of how it was transported.

## 4.2.1
- Fixed `AlarmType.fromJson` cast error when filtering alarms by type

## 4.2.0
- Added `ImageService` for managing image uploads
- Fixed `AlarmComment.comment` deserialization into `AlarmCommentJsonNode`
- Fixed analyzer warnings (unused imports, deprecation messages, identifier naming)
- Removed duplicate exports in `mobile_models` and `service` barrels

## 4.1.0
- Thingsboard 4.3.0+ support
- Api key management
- Api key auth support
- 2Fa force support
## 4.0.0
- Changes in TbStorage interface

## 3.0.1

- Adapted to backend changes for version information representation.
- Fixed signup discrepancy.

## 3.0.0

- Introduced a new API for dynamically configuring via mobile center.
- The minimum supported TB version is 3.9.0 and higher.

## 2.0.0

- Enhanced TbStorage interface for improved usability.
- Introduced a new API for alarm activity management, including support for comments and additional functionalities.

## 1.3.1

- Increased the minimum supported ThingsBoard version to 3.8.0.

## 1.3.0

- **New APIs:**
    - `/api/alarm/types` - Fetches available alarm types.
    - `/api/users/info` - Retrieves user information.

- **Enhancements:**
    - Added the ability to log request and response details for improved debugging.

- **Bug Fixes:**
    - Various minor bug fixes to improve stability and performance.

## 1.2.0

- Introduced the ability to configure access to custom applications using a login with a QR code feature.
- Update API and models according to ThingsBoard platform version 3.7.0
- Fixed the issue with resolving supported platform versions.
- Implemented other minor fixes.

## 1.1.1

- Introduced a NotificationService, which allows you to receive notification data. 

## 1.1.0

- Updated the API and models to align with the latest ThingsBoard platform, version 3.6.3
- Introduced support for push notifications

## 1.0.9

- Update API and models according to ThingsBoard platform version 3.6.2
- Fixed issue [#13](https://github.com/thingsboard/dart_thingsboard_client/issues/13): Problem occurred when using web socket and loosing internet
- Fixed issue [#19](https://github.com/thingsboard/dart_thingsboard_client/issues/19): incorrect AlarmDataCmd
- Fixed issue [#21](https://github.com/thingsboard/dart_thingsboard_client/issues/21): incorrect updated notification in subscription

## 1.0.8

- Update API and models according to ThingsBoard platform version 3.6.0
- Fixed issue [#17](https://github.com/thingsboard/dart_thingsboard_client/issues/17): get json attributes when value is array

## 1.0.7

- Fixed incorrect deserializing alarm models

## 1.0.6

- Update API and models according to ThingsBoard platform version 3.5.0

## 1.0.5

- Update API and models according to ThingsBoard platform version 3.4.2

## 1.0.4

- Update API and models according to ThingsBoard platform version 3.4.0
- Added MFA support
- Fix dart analysis issues

## 1.0.3

- Add `terms of use` to self-registration parameters 

## 1.0.2

- Add support for web platform

## 1.0.1

- Improve description
- Improve pubspec: add github links
- Use formatting according to dartfmt

## 1.0.0

- Initial version, created by Igor Kulikov
