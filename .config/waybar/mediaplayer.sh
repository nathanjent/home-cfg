#!/bin/bash

status=$(playerctl status)
metadata=$(playerctl metadata --format '{{ playerName }} | {{ trunc(markup_escape(artist), 10) }} - {{ trunc(markup_escape(title), 10) }}')

# percentage sets pause/play icon

if [ "$status" = "Playing" ]; then
    echo "{ \"alt\": \"$status\", \"text\": \"$metadata\", \"tooltip\": \"$status\", \"class\": \"${status,,}\"  }"
elif [ "$status" = "Paused" ]; then
    echo "{ \"alt\": 0, \"text\": \"$metadata\", \"tooltip\": \"$status\", \"class\": \"${status,,}\" }"
fi
