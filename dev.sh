#!/usr/bin/env bash
# Start database, backend API and frontend. Ctrl+C stops the API and frontend.
set -euo pipefail
cd "$(dirname "$0")"

docker compose -f backend/LifeAtMiles.Backend.Database/compose.yml up -d

trap 'kill 0' EXIT INT TERM
dotnet run --project backend/LifeAtMiles.Backend.API 2>&1 | sed -u 's/^/[api] /' &
npm --prefix frontend run dev 2>&1 | sed -u 's/^/[web] /' &
wait
