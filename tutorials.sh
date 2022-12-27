#!/usr/bin/env bash
set -eou pipefail

cd "$(dirname "$0")"
echo -e '= [[tutorials]] Articles or Tutorials\n' > tutorials.adoc
regex='^. https:\/\/paulojeronimo.com\/.*\(labs\|tutorial\|presentation\|article\)'
tag_tutorials=
for tag in data/*
do
  tutorials=$(sed -n "/$regex/p" $tag | cut -d' ' -f-2 && echo)
  tag_tutorials=$(echo -e "$tutorials\n$tag_tutorials")
done
sed '/^[[:space:]]*$/d' <<< "$tag_tutorials" | \
  sort | uniq | grep -E -v '(docker-labs|jq-labs)' >> tutorials.adoc
