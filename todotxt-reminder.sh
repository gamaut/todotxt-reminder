#!/bin/bash

set -euo pipefail

TODO_FILE="todo.txt"
TODAY=$(date +%Y-%m-%d)
TOMORROW=$(date -d tomorrow +%Y-%m-%d)

generate_list() {
    local context

    mapfile -t contexts < <(
        grep -v "^x " "$TODO_FILE" | awk -v today="$TODAY" -v tomorrow="$TOMORROW" '
        /due:/ {
            due_date = gensub(/.*due:([0-9]{4}-[0-9]{2}-[0-9]{2}).*/, "\\1", "g", $0)
            if (due_date <= today || due_date == tomorrow) {
                match($0, /@[^\s]+/, arr)
                if (arr[0] != "") print arr[0]
            }
        }
        ' | sort -u
    )

    for context in "${contexts[@]}"; do
        echo
        echo "$context"

        grep -v "^x " "$TODO_FILE" | grep "$context" | sed "s/$context//g" | awk -v today="$TODAY" -v tomorrow="$TOMORROW" '
            /due:/ {
                due_date = gensub(/.*due:([0-9]{4}-[0-9]{2}-[0-9]{2}).*/, "\\1", "g", $0)
                if (due_date <= today || due_date == tomorrow) print
            }
        '
    done
}

generate_list
