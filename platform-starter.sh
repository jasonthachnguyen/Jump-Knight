#!/bin/sh
printf '\033c\033]0;%s\a' platform-starter
base_path="$(dirname "$(realpath "$0")")"
"$base_path/platform-starter.x86_64" "$@"
