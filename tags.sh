#!/usr/bin/env bash
set -eou pipefail

cd "$(dirname "$0")"
echo -e '= Tags\n' > tags.adoc
echo -e '.NUMBER_OF_TAGS tags\n****\n' >> tags.adoc
tags=$(ls data | sed 's/\.adoc//g')
sed 's/\(.*\)/{\1}/g' <<< "$tags" | \
  xargs | sed 's/ / | /g' >> tags.adoc
echo '****' >> tags.adoc
rm -f tag-attributes.adoc
add-tag() {
  echo -e ":$1: <<$2,$3>>" >> tag-attributes.adoc
  echo -e "include::data/$2.adoc[]\n" >> tags.adoc
}
sed -i 's/{asciidoctor}/{_asciidoctor}/g' tags.adoc
add-tag _asciidoctor asciidoctor Asciidoctor
tags=$(grep -v asciidoctor <<< "$tags")
for tag in $tags
do
  tag_title=$(sed -n "/^\[#.*\]#\(.*\)#.*::$/p" data/$tag.adoc | cut -d'#' -f3)
  add-tag $tag $tag "$tag_title"
done
sed -i "s/NUMBER_OF_TAGS/$(wc -l < tag-attributes.adoc)/g" tags.adoc
