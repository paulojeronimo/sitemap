#!/usr/bin/env bash
set -eou pipefail

cd "`dirname "$0"`"

if [[ ${1:-} != gh-pages ]]
then
  ./tutorials.sh
  ./tags.sh
fi

# https://gist.github.com/paulojeronimo/95977442a96c0c6571064d10c997d3f2
GENERATE_PDF=${GENERATE_PDF:-false} docker-asciidoctor-builder "$@"
