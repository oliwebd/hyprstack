#!/usr/bin/env bash
set -euo pipefail

# Dependencies: swww

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/image.jpg"
    exit 1
fi

swww img "$1" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps 60 \
    --transition-type grow \
    --transition-duration 0.7
