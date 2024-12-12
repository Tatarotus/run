#!/usr/bin/env bash

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
filter=""
dry="1"

while [[ $# > 0 ]]; do
  if [[ $1 == "--dry" ]]; then
    dry="1"
  else
    filter="$1"
  fi
  shift
done

log() {
  if [[ $dry == "1" ]]; then
    echo "[DRY_RUN]: $@"
  else
    echo "$@"
  fi
}

execute() {
  log "execute $@"
  if [[ $dry == "1" ]]; then
    return
  fi
  "$@"
}

log "$script_dir -- $filter"

cd "$script_dir" || exit 1

# Collect scripts in an array to handle spaces and special characters
mapfile -t scripts < <(find ./runs -maxdepth 1 -mindepth 1 -executable -type f)

for script in "${scripts[@]}"; do
  # Skip filtering if filter is empty
  if [[ -n "$filter" && ! "$script" =~ $filter ]]; then
    log "filtering $script"
    continue
  fi
  echo "Executing $script"
  execute "./$script"
done
