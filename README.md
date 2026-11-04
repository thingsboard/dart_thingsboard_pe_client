# thingsboard_pe_client (discontinued)

**This package is deprecated and no longer maintained.** ThingsBoard CE and PE are now a single product, and
`thingsboard_pe_client` has been replaced by [`thingsboard_client`](https://pub.dev/packages/thingsboard_client)
([GitHub](https://github.com/thingsboard/dart_thingsboard_client)).

Version 5.0.0 of this package contains no code of its own: it only re-exports
`package:thingsboard_client/thingsboard_client.dart` (`thingsboard_client: ^5.0.0`), so existing imports of the main
library keep compiling while your IDE shows a deprecation warning.

> Version 5.0 of `thingsboard_client` is generated from the ThingsBoard OpenAPI spec and its API differs from
> `thingsboard_pe_client` 4.x. See the
> [thingsboard_client CHANGELOG](https://pub.dev/packages/thingsboard_client/changelog) for details.

## Migration

1. In `pubspec.yaml`, replace the dependency:

   ```yaml
   dependencies:
     thingsboard_client: ^5.0.0   # was: thingsboard_pe_client: ^4.x
   ```

2. Rewrite the imports:

   ```sh
   grep -rl "package:thingsboard_pe_client/" lib test | xargs sed -i 's#package:thingsboard_pe_client/thingsboard_pe_client.dart#package:thingsboard_client/thingsboard_client.dart#g; s#package:thingsboard_pe_client/#package:thingsboard_client/#g'
   ```

3. Fetch dependencies and check the result:

   ```sh
   flutter pub get && flutter analyze
   ```

**Note:** only the main library is re-exported. Deep imports such as `package:thingsboard_pe_client/src/...` do
**not** work through this package any more, so they must be migrated to `thingsboard_client`.

Please file issues at the [thingsboard_client issue tracker](https://github.com/thingsboard/dart_thingsboard_client/issues).
