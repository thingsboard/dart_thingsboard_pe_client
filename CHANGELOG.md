## 5.0.0
- **Deprecated:** `thingsboard_pe_client` is discontinued and replaced by
  [`thingsboard_client`](https://pub.dev/packages/thingsboard_client) (ThingsBoard CE and PE are now one product).
- The package no longer contains any implementation: it only re-exports `thingsboard_client: ^5.0.0`.
  `thingsboard_pe_client.dart`, `thingsboard_client.dart` and every `src/...` library are marked `@Deprecated`,
  so existing code compiles with deprecation diagnostics.
- The API is the same OpenAPI-generated API as in 4.4.x (`get*ControllerApi()`, built_value models).
- Deep imports (`package:thingsboard_pe_client/src/...`) keep working through deprecated stubs that re-export
  the same files of `thingsboard_client`. `ThingsboardPeClient` (from `src/api.dart`) is a deprecated alias of the
  generated `ThingsboardClient`. The stubs are generated once by `tool/gen_stubs.sh` and cover every 4.4.x file.
- **BREAKING:** 65 constants in 18 enums are renamed to the plain generator names (the values sent over the
  wire are unchanged), e.g. `SignUpFieldId.aDDRESS2` → `ADDRESS2`, `EntityType.oAUTH2CLIENT` → `OAUTH2_CLIENT`,
  `DeviceTransportType.lWM2M` → `LWM2M`, `DeviceCredentialsType.x509CERTIFICATE` → `X509_CERTIFICATE`,
  `ThingsboardErrorCode.n10` → `number10`. The full list is in the "Migrating from `thingsboard_pe_client` 4.4.x"
  entry of the [thingsboard_client 5.0.0 CHANGELOG](https://pub.dev/packages/thingsboard_client/changelog#500).
- **BREAKING:** `SolutionControllerApi` (`getSolutionControllerApi()`) and the solution template models
  (`ComplexOperation`, `SolutionInstallResponse`, `SolutionTemplateLevel`, `TenantSolutionTemplateDetails`,
  `TenantSolutionTemplateInfo`, `TenantSolutionTemplateInstructions`) are removed. They were generated from a
  4.4.0 snapshot spec and are not part of the ThingsBoard 4.4.0 release; deep imports of these files no longer work.
- **BREAKING** (model fixes from the OpenAPI spec, no compatible alias possible):
  - `AliasEntityId.entityType` is now `String` (was `EntityType`) and `AliasEntityId.id` is now `String?`.
  - `RefreshTokenRequest.refreshToken` is now `String?` (was `JsonObject?`).
  - `ColumnSettings.type` is removed.
  - `Lwm2mControllerApi.saveLwm2mDeviceWithCredentials` now takes `requestBody` as `BuiltMap<String, JsonObject?>`.
- **BREAKING:** minimum Dart SDK is now 3.10.0 (Flutter 3.38+); older SDKs are dropped for security reasons.
- Note for users upgrading from 4.2.x or earlier: 4.4.0 already replaced the handwritten API
  (`getUserService()`, `getDeviceService()`, ...) with the generated one, and that release was breaking.
  This release does not restore the 4.2.x API.
- Migration: see the [README](https://github.com/thingsboard/dart_thingsboard_pe_client#migration).

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
