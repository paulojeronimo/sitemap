#!/usr/bin/env bash
set -eou pipefail

# https://gist.github.com/paulojeronimo/95977442a96c0c6571064d10c997d3f2
GENERATE_PDF=${GENERATE_PDF:-false} docker-asciidoctor-builder "$@"
