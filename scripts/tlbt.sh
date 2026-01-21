#!/usr/bin/env bash

#
# dependencies: tldr, glow, sd
#

env=/usr/bin/env

[[ $# -eq 0 ]] && { $env tldr; exit 0; }

$env tldr -m $@ 2>&1 | $env sd '\{\{(.+?)\}\}' '$1' | $env glow

unset env

exit 0
