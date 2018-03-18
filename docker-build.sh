#!/usr/bin/env bash

# Download image to cache from, up to three refs behind
PREV_REFS=(
  "$(git rev-parse --short HEAD~)"
  "$(git rev-parse --short HEAD~~)"
  "$(git rev-parse --short HEAD~~~)"
)
for REF in "${PREV_REFS[@]}"; do
  PREV_IMAGE="${CI_REGISTRY_IMAGE}:${REF}"
  docker pull "${PREV_IMAGE}" && break
done

function get_git_root() {
  git rev-parse --show-toplevel \
  || "$(dirname "${0}")"
}

docker build \
  --tag "${IMAGE_URL}" \
  --cache-from "${PREV_IMAGE}" \
  "$(get_git_root)"