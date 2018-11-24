#!/usr/bin/env sh

# Download image to cache from, up to three refs behind
for REF in \
  "$(git rev-parse HEAD~)" \
  "$(git rev-parse HEAD~~)" \
  "$(git rev-parse HEAD~~~)"; do

  PREV_IMAGE="${CI_REGISTRY_IMAGE}:${REF}"
  docker pull "${PREV_IMAGE}" && break
done

get_git_root() {
  git rev-parse --show-toplevel || dirname "${0}"
}

docker build \
  --tag "${IMAGE_URL}" \
  --cache-from "${PREV_IMAGE}" \
  "$(get_git_root)"
