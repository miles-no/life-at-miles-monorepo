#!/usr/bin/env bash
# One-time setup: init submodules and install frontend dependencies.
# No secrets needed; ./dev.sh supplies placeholder config.
set -euo pipefail
cd "$(dirname "$0")"

for cmd in git docker dotnet node npm; do
  command -v "$cmd" >/dev/null || { echo "Missing prerequisite: $cmd"; exit 1; }
done

git submodule update --init --recursive
npm --prefix frontend ci
dotnet restore backend/LifeAtMiles.Backend.sln

echo "Done. Start everything with ./dev.sh"
