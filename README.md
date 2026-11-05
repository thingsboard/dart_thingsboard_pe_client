# thingsboard_pe_client (discontinued)

**This package is deprecated and no longer maintained.** ThingsBoard CE and PE are now a single product, and
`thingsboard_pe_client` has been replaced by [`thingsboard_client`](https://pub.dev/packages/thingsboard_client)
([GitHub](https://github.com/thingsboard/dart_thingsboard_client)).

Version 5.0.0 of this package contains no code of its own: its main library only re-exports
`package:thingsboard_client/thingsboard_client.dart` (`thingsboard_client: ^5.0.0`), so code that imports the main
library mostly keeps compiling, with a deprecation diagnostic. Deep imports
(`package:thingsboard_pe_client/src/...`) are not supported.

Main breaking changes relative to 4.4.x: the telemetry WebSocket API, the login models and `Authority` use the
generated built_value models; `PushNotification*` is replaced by `Notification`; 68 enum constants are renamed;
`DeviceApiControllerApi` and `SolutionControllerApi` are removed. The full guide is
[Migrating from `thingsboard_pe_client` 4.4.x](https://github.com/thingsboard/dart_thingsboard_client/blob/master/MIGRATION.md#migrating-from-thingsboard_pe_client-44x).

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
`thingsboard_client`. Prefer the main library `package:thingsboard_client/thingsboard_client.dart`: `src/` is not
public API, and some 4.4.x files no longer exist.

Please file issues at the [thingsboard_client issue tracker](https://github.com/thingsboard/dart_thingsboard_client/issues).
