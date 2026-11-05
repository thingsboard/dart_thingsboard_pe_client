#!/usr/bin/env bash
# Generates lib/src/** compatibility stubs: one deprecated library per
# non-part library of package:thingsboard_client/src that also existed in
# thingsboard_pe_client 4.4.x, re-exporting it, so deep imports from 4.4.x
# (package:thingsboard_pe_client/src/...) keep compiling. Files that only
# exist in thingsboard_client get no stub; 4.4.x files removed from
# thingsboard_client (e.g. the solution templates API) get none either.
#
# The stubs are generated once for the frozen 5.0.0 release. They do not need
# to be regenerated for later thingsboard_client minors: old users never import
# files that did not exist in 4.4.x.
#
# Usage: tool/gen_stubs.sh [path/to/dart_thingsboard_client] [path/to/thingsboard_pe_client-4.4.x]
set -euo pipefail

cd "$(dirname "$0")/.."
client_lib="${1:-../dart_thingsboard_client}/lib"
old_lib="${2:-${PUB_CACHE:-$HOME/.pub-cache}/hosted/pub.dev/thingsboard_pe_client-4.4.1}/lib"
for d in "$client_lib/src" "$old_lib/src"; do
  [ -d "$d" ] || { echo "not found: $d" >&2; exit 1; }
done

rm -rf lib/src
comm -12 \
  <(cd "$client_lib" && grep -rL --include='*.dart' '^part of' src | sort) \
  <(cd "$old_lib" && find src -name '*.dart' | sort) |
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

// ignore: implementation_imports
import 'package:thingsboard_client/src/api.dart' as generated;

export 'package:thingsboard_client/src/api.dart';

@Deprecated('Use ThingsboardClient from package:thingsboard_client instead')
typedef ThingsboardPeClient = generated.ThingsboardClient;
EOF

# 4.4.x declared a handwritten Direction in sort_order.dart; it is now the
# generated Direction (same ASC/DESC constants) that SortOrder takes.
cat > lib/src/model/page/sort_order.dart <<'EOF'
@Deprecated('Use package:thingsboard_client/thingsboard_client.dart instead')
library;

export 'package:thingsboard_client/src/model/direction.dart' show Direction;
export 'package:thingsboard_client/src/model/page/sort_order.dart';
EOF

echo "generated $(find lib/src -name '*.dart' | wc -l) stubs"
