#!/usr/bin/env bash

#
# dependencies: ollama, gum, glow
#

env=/usr/bin/env
prompt="$(/usr/bin/env gum write --placeholder='Ask Gemma...')"

if [[ -z "${prompt//[[:space:]]}" ]]; then
  echo "No prompt" > /dev/stderr
  exit 1
fi

file=$(mktemp /tmp/gemma_XXXXXX)
trap "rm -f $file" EXIT

$env gum spin --title "Processing your request..." -- $env ollama run gemma3 "$prompt" > $file || { echo "Error processing your request" > /dev/stderr; exit 1; }

echo -e "\n$prompt\n"
$env glow $file
rm $file

unset env
unset prompt
unset file

exit 0
