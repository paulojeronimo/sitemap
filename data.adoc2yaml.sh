#!/usr/bin/env bash
set -eou pipefail

cd "$(dirname "$0")"
#head_regex='^\[#\(.*\)\]#\(.*\)#\(.*\)::$'
url_regex=','
for adoc_file in data/*.adoc
do
  yaml_file=${adoc_file%.adoc}.yaml
  tag_head=$(head -1 $adoc_file)
  #tag_id=$(sed "s/$head_regex/\1/g" <<< "$tag_head")
  tag_id=$(cut -d'#' -f2 <<< "$tag_head")
  tag_id=${tag_id%]}
  #tag_title=$(sed "s/$head_regex/\2/g" <<< "$tag_head")
  tag_title=$(cut -d'#' -f3 <<< "$tag_head")
  #tag_url=$(sed "s/$head_regex/\3/g" <<< "$tag_head")
  tag_url=$(cut -d'#' -f4 <<< "$tag_head" | \
    sed 's,^.*http\(\|s\)://\(.*\)::$,http\1://\2,g')
  cat <<EOF>$yaml_file
id: $tag_id
title: $tag_title
url: $tag_url
EOF
done
