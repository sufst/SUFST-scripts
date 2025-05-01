#!/bin/sh

#
# Usage: ./test/drc.sh <pcb>
#
# Runs the KiCad design rules checker on the provided PCB, exiting with a non-zero exit code on errors
#

set -e

log="$(date +"drc-log-%Y.%m.%d-%H.%M.%S.txt")"

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
    echo "Usage: $0 <pcb>"
fi

if ! [ -f "$path" ]; then
    die "'$path' does not exist"
fi

ext="$(basename "$path" | sed 's/^.*\.\(.*\)$/\1/')"

if [ "$ext" != "kicad_pcb" ]; then
    die "File extension must be 'kicad_pcb'"
fi

if ! kicad-cli pcb drc "$path" --output "$log" --severity-error --exit-code-violations; then
    cat "$log"
    [ -n "$LOG_LOCATION" ] && mv "$log" "$LOG_LOCATION"
    die "Non-zero DRC errors"
fi

[ -n "$LOG_LOCATION" ] && mv "$log" "$LOG_LOCATION"

cleanup
