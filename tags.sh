#!/usr/bin/env bash
set -eou pipefail

cd "$(dirname "$0")"
echo -e '= Tags\n' > tags.adoc
echo '****' >> tags.adoc
regex='^\[#\(.*\)\]#.*#::$'
sed -n "/$regex/p" README.adoc | \
  sed "s/$regex/<<\1>>/g" | sort >> tags.adoc
echo '****' >> tags.adoc
