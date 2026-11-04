#!/usr/bin/env bash
# Generates lib/src/** compatibility stubs: one deprecated library per
# non-part library of package:thingsboard_client/src, re-exporting it, so
# deep imports from thingsboard_pe_client 4.4.x
# (package:thingsboard_pe_client/src/...) keep compiling.
#
# The stubs are generated once for the frozen 5.0.0 release. They do not need
# to be regenerated for later thingsboard_client minors: old users never import
# files that did not exist in 4.4.x.
#
# Usage: tool/gen_stubs.sh [path/to/dart_thingsboard_client]
set -euo pipefail

cd "$(dirname "$0")/.."
client_lib="${1:-../dart_thingsboard_client}/lib"
[ -d "$client_lib/src" ] || { echo "not found: $client_lib/src" >&2; exit 1; }

rm -rf lib/src
(cd "$client_lib" && grep -rL --include='*.dart' '^part of' src | sort) |
  while read -r f; do
    mkdir -p "lib/$(dirname "$f")"
    cat > "lib/$f" <<EOF
@Deprecated('Use package:thingsboard_client/thingsboard_client.dart instead')
library;

export 'package:thingsboard_client/$f';
EOF
  done

# 4.4.x named the raw generated client ThingsboardPeClient.
cat > lib/src/api.dart <<'EOF'
@Deprecated('Use package:thingsboard_client/thingsboard_client.dart instead')
library;

import 'package:thingsboard_client/src/api.dart' as generated;

export 'package:thingsboard_client/src/api.dart';

@Deprecated('Use ThingsboardClient from package:thingsboard_client instead')
typedef ThingsboardPeClient = generated.ThingsboardClient;
EOF

echo "generated $(find lib/src -name '*.dart' | wc -l) stubs"
