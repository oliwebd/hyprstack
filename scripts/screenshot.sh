#!/usr/bin/env bash
set -euo pipefail

# Dependencies: grim, slurp, swappy, wl-clipboard

mkdir -p "$HOME/Pictures/Screenshots"
FILE="$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

grim -g "$(slurp)" - | swappy -f - -o "$FILE"
wl-copy < "$FILE"
notify-send "Screenshot taken" "Saved to $FILE and copied to clipboard" -i "$FILE"
