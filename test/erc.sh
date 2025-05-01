#!/bin/sh

#
# Usage: ./test/erc.sh <schematic>
#
# Runs the KiCad electrical rules checker on the provided schematic, exiting with a non-zero exit code on errors
#

set -e

log="$(date +"erc-log-%Y.%m.%d-%H.%M.%S.txt")"

cleanup() {
    rm -f "$log"
}

die() {
    echo "$*"
    cleanup
    exit 1
}

path="$1"

if [ -z "$path" ]; then
    echo "Usage: $0 <schematic>"
fi

if ! [ -f "$path" ]; then
    die "'$path' does not exist"
fi

ext="$(basename "$path" | sed 's/^.*\.\(.*\)$/\1/')"

if [ "$ext" != "kicad_sch" ]; then
    die "File extension must be 'kicad_sch'"
fi

if ! KICAD_SYMBOL_DIR="/usr/share/kicad/symbols" kicad-cli sch erc "$path" --output "$log" --severity-error --exit-code-violations; then
    cat "$log"
    [ -n "$LOG_LOCATION" ] && mv "$log" "$LOG_LOCATION"
    die "Non-zero ERC errors"
fi

[ -n "$LOG_LOCATION" ] && mv "$log" "$LOG_LOCATION"

cleanup
