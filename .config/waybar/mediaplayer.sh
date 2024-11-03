#!/bin/bash

status=$(playerctl status)
metadata=$(playerctl metadata --format '{{ artist }} - {{ title }}')

# percentage sets pause/play icon

if [ "$status" = "Playing" ]; then
    echo "{ \"percentage\": 100, \"text\": \"$metadata\", \"tooltip\": \"$status\", \"class\": \"${status,,}\"  }"
elif [ "$status" = "Paused" ]; then
    echo "{ \"percentage\": 0, \"text\": \"$metadata\", \"tooltip\": \"$status\", \"class\": \"${status,,}\" }"
fi
