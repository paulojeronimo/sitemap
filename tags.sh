#!/usr/bin/env bash
set -eou pipefail

cd "$(dirname "$0")"
echo -e '= Tags\n' > tags.adoc
echo -e '.NUMBER_OF_TAGS tags:\n****\n' >> tags.adoc
tags=$(ls data | sed 's/\.adoc//g')
sed 's/\(.*\)/{\1}/g' <<< "$tags" | \
  xargs | sed 's/ / | /g' >> tags.adoc
echo '****' >> tags.adoc
rm -f tag-attributes.adoc
add-tag() {
  echo -e ":$1: <<$1,$1>>" >> tag-attributes.adoc
  echo -e ":$1_: <<$1,$2>>" >> tag-attributes.adoc
  echo -e "\ninclude::data/$1.adoc[]" >> tags.adoc
}
for tag in $tags
do
  tag_title=$(sed -n "/^\[#.*\]#\(.*\)#.*::$/p" data/$tag.adoc | cut -d'#' -f3)
  add-tag $tag "$tag_title"
done
NUMBER_OF_TAGS=$(bc <<< "$(wc -l <<< "$(<tag-attributes.adoc)")/2")
sed -i "s/NUMBER_OF_TAGS/$NUMBER_OF_TAGS/g" tags.adoc
