## 5.0.0
- **Deprecated:** `thingsboard_pe_client` is discontinued and replaced by
  [`thingsboard_client`](https://pub.dev/packages/thingsboard_client) (ThingsBoard CE and PE are now one product).
- The package no longer contains any implementation: its main library `thingsboard_pe_client.dart` (and the
  4.2.x main library `thingsboard_client.dart`) only re-export `package:thingsboard_client/thingsboard_client.dart`
  (`thingsboard_client: ^5.0.0`) and are marked `@Deprecated`.
- Migration guide: [Migrating from `thingsboard_pe_client` 4.4.x](https://github.com/thingsboard/dart_thingsboard_client/blob/master/MIGRATION.md#migrating-from-thingsboard_pe_client-44x) in `MIGRATION.md` of
  `thingsboard_client`. Main breaking changes relative to 4.4.x:
  - deep imports (`package:thingsboard_pe_client/src/...`) no longer work; only the main library is re-exported;
  - the telemetry WebSocket API works on the generated built_value models (`DeviceId((b) => b..id = uuid)`,
    immutable updates, `Notification` instead of `PushNotification*`);
  - `LoginRequest`, `LoginResponse` and `RefreshTokenRequest` are the generated built_value models;
  - `Authority` is a single generated type, and `AuthUser.authority` is `null` for an anonymous user;
  - 68 enum constants in 19 enums are renamed (`EntityType.oAUTH2CLIENT` → `OAUTH2_CLIENT`, ...);
  - `DeviceApiControllerApi` and `SolutionControllerApi` are removed;
  - minimum Dart SDK 3.10.0 (Flutter 3.38+).
- Note for users upgrading from 4.2.x or earlier: 4.4.0 already replaced the handwritten API
  (`getUserService()`, `getDeviceService()`, ...) with the generated one, and that release was breaking. See
  [Migrating from `thingsboard_client` 4.x](https://github.com/thingsboard/dart_thingsboard_client/blob/master/MIGRATION.md#migrating-from-thingsboard_client-4x-421).

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
