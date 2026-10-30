#!/usr/bin/env bash
# One-time setup: submodules, backend config + DB, frontend env + deps.
set -euo pipefail
cd "$(dirname "$0")"

for cmd in git docker dotnet node npm; do
  command -v "$cmd" >/dev/null || { echo "Missing prerequisite: $cmd"; exit 1; }
done

git submodule update --init --recursive

(cd backend && ./setup-dev.sh)

if [ ! -f frontend/.env.local ]; then
  cp frontend/.env.example frontend/.env.local
  echo "Created frontend/.env.local - add AZURE_CLIENT_SECRET (ask a maintainer, see frontend/README.md)."
fi
npm --prefix frontend ci

echo "Done. Start everything with ./dev.sh"
