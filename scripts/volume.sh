#!/usr/bin/env bash
set -euo pipefail

# Dependencies: wpctl (WirePlumber), swaync-client or notify-send

ACTION="$1"

case "$ACTION" in
    up)
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 [up|down|mute]"
        exit 1
        ;;
esac

# Get current volume
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED || true)

if [ "$MUTED" -eq 1 ]; then
    notify-send -t 1000 -h string:x-canonical-private-synchronous:sys-notify -u low "Volume Muted" "🔇"
else
    notify-send -t 1000 -h string:x-canonical-private-synchronous:sys-notify -u low "Volume" "🔊 $VOL%"
fi
