# thingsboard_pe_client (discontinued)

**This package is deprecated and no longer maintained.** ThingsBoard CE and PE are now a single product, and
`thingsboard_pe_client` has been replaced by [`thingsboard_client`](https://pub.dev/packages/thingsboard_client)
([GitHub](https://github.com/thingsboard/dart_thingsboard_client)).

Version 5.0.0 of this package contains no code of its own: its main library only re-exports
`package:thingsboard_client/thingsboard_client.dart` (`thingsboard_client: ^5.0.0`), so REST code written for
`thingsboard_pe_client` 4.4.x that imports the main library mostly keeps compiling, with a deprecation diagnostic.
Deep imports (`package:thingsboard_pe_client/src/...`) are not supported: migrate them to `thingsboard_client`.

> **Breaking changes.** The telemetry WebSocket API and the login models (`LoginRequest`, `LoginResponse`,
> `RefreshTokenRequest`) now use the generated built_value models, so their syntax changed (for example
> `DeviceId(uuid)` → `DeviceId((b) => b..id = uuid)`, `LoginRequest((b) => b..username = u..password = p)`).
> `PushNotification*` is replaced by the generated `Notification`. `Authority` is a single generated type and
> `AuthUser.authority` is nullable. 68 enum constants are renamed (e.g. `SignUpFieldId.aDDRESS2` → `ADDRESS2`), a
> few model fields changed type (e.g. `AliasEntityId.entityType` is now `String`), and `DeviceApiControllerApi` and
> `SolutionControllerApi` are removed. See the
> [CHANGELOG](CHANGELOG.md) and the migration guide in the
> [thingsboard_client 5.0.0 CHANGELOG](https://pub.dev/packages/thingsboard_client/changelog#500).
>
> Code written for 4.2.x or earlier (`getUserService()`, ...) was already broken by 4.4.0 and must be migrated
> to the generated API.

## Migration

1. In `pubspec.yaml`, replace the dependency:

   ```yaml
   dependencies:
     thingsboard_client: ^5.0.0   # was: thingsboard_pe_client: ^4.x
   ```

2. Rewrite the imports:

   ```sh
   grep -rl "package:thingsboard_pe_client/" lib test 2>/dev/null | while read -r f; do
     perl -pi -e 's#package:thingsboard_pe_client/thingsboard_pe_client\.dart#package:thingsboard_client/thingsboard_client.dart#g; s#package:thingsboard_pe_client/#package:thingsboard_client/#g' "$f"
   done
   ```

   The command works on Linux and macOS (`perl` is preinstalled on both). It also renames
   `package:thingsboard_pe_client/thingsboard_client.dart`, the old main library of 4.2.x and earlier.

3. Fetch dependencies and check the result:

   ```sh
   flutter pub get && flutter analyze
   ```

The command above also rewrites deep imports (`package:thingsboard_pe_client/src/...`) to the same paths in
`thingsboard_client`. Prefer replacing them with `package:thingsboard_client/thingsboard_client.dart`, which
exports the public API including the replacement types: `src/` is not public API, and some 4.4.x files no longer
exist (for example `src/model/login_models.dart`, `src/model/id/*`, `src/model/telemetry/query/**`).

Please file issues at the [thingsboard_client issue tracker](https://github.com/thingsboard/dart_thingsboard_client/issues).
