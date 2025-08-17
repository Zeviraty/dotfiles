#!/bin/bash

BASE_DIR="$HOME"
CACHE_FILE="$HOME/.cache/git_commit_count.txt"
today=$(date +%F)

mkdir -p "$(dirname "$CACHE_FILE")"

# Count all commits from today
count=0
while IFS= read -r gitdir; do
    repo=$(dirname "$gitdir")
    cd "$repo" || continue
    c=$(git log --author="zeviraty" --since="$today 00:00" --until="$today 23:59" --pretty=tformat:"%h" 2>/dev/null | wc -l)
    count=$((count + c))
done < <(find "$BASE_DIR" -type d -name ".git" 2>/dev/null)

echo "$count"

# Save to cache file
if [ "$count" -eq 0 ]; then
    echo "No commits today" > "$CACHE_FILE"
else
    echo "$count commit(s) today" > "$CACHE_FILE"
fi

