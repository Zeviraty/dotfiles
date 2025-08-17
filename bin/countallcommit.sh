#!/bin/bash

BASE_DIR="$HOME"
CACHE_FILE="$HOME/.cache/git_commit_count.txt"
today=$(date +%F)

GIT_AUTHOR="zeviraty"

mkdir -p "$(dirname "$CACHE_FILE")"

# Count all commits from today
count=0
while IFS= read -r gitdir; do
    repo=$(dirname "$gitdir")
    cd "$repo" || continue
    c=$(git log --all --author="$GIT_AUTHOR" --pretty=tformat:"%h" | wc -l)
    count=$((count + c))
done < <(find "$BASE_DIR" -type d -name ".git" 2>/dev/null)

echo "$count"
