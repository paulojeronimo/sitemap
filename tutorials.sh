#!/usr/bin/env bash
set -eou pipefail

cd "$(dirname "$0")"
echo -e '= Tutorials\n' > tutorials.adoc
regex='^. https:\/\/.*\(labs\|tutorial\|presentation\)'
sed -n "/$regex/p" README.adoc | sort | uniq | \
  grep -E -v '(docker-labs|jq-labs)' >> tutorials.adoc
