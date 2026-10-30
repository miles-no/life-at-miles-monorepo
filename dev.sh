#!/usr/bin/env bash
# Start database, backend API and frontend with mocked secrets - no credentials needed.
# Sign in with the Regular / Servant / Admin dev-login buttons (@miles.test users).
# Ctrl+C stops the API and frontend.
set -euo pipefail
cd "$(dirname "$0")"

if docker compose version >/dev/null 2>&1; then COMPOSE="docker compose"
elif command -v docker-compose >/dev/null; then COMPOSE="docker-compose"
else echo "Docker Compose not found"; exit 1; fi

$COMPOSE -f backend/LifeAtMiles.Backend.Database/compose.yml up -d

# Backend config via env vars (override appsettings; no files in the submodule are touched).
# Flowcase, Slack, Unsplash etc. are left unconfigured, so the backend uses its no-op clients.
export ASPNETCORE_ENVIRONMENT=Development
export DevAuth__SigningKey="local-dev-signing-key-0123456789abcdef-xyz"
export ApiKey="local-dev-api-key"
export Azure__TenantId="7534ab3e-6d52-4213-8493-1d674b529724"
export Azure__ClientId="5787478e-2456-4e83-b975-0f97caeb9aa6"
export Azure__ClientSecret="local-placeholder"
export Encryption__FieldEncryptionKey="bG9jYWwtZGV2LWZpZWxkLWVuY3J5cHRpb24ta2V5ISE="
export Backend__BaseUrl="http://localhost:5108"
export Backend__ImageHashSecret="local-image-hash-secret"
export Frontend__BaseUrl="http://localhost:5173"
export DbConnectionString="Host=localhost;Port=5480;Database=LifeAtMiles;Username=lifeatmiles;Password=lifeatmiles_dev"

# Frontend config: placeholder Entra secret (only the dev-login buttons work).
export AZURE_CLIENT_SECRET="${AZURE_CLIENT_SECRET:-local-placeholder}"
export AZURE_CLIENT_ID="${AZURE_CLIENT_ID:-5787478e-2456-4e83-b975-0f97caeb9aa6}"
export AZURE_TENANT_ID="${AZURE_TENANT_ID:-7534ab3e-6d52-4213-8493-1d674b529724}"
export AZURE_REDIRECT_URI="${AZURE_REDIRECT_URI:-http://localhost:5173/auth/microsoft/callback}"
export SESSION_SECRET="${SESSION_SECRET:-debug_secret_key_for_development_only}"
export DATABASE_URL="${DATABASE_URL:-postgresql://lifeatmiles:lifeatmiles_dev@localhost:5480/LifeAtMiles}"
export BACKEND_BASE_URI="${BACKEND_BASE_URI:-http://localhost:5108}"

trap 'kill 0' EXIT INT TERM
dotnet run --project backend/LifeAtMiles.Backend.API --no-launch-profile --urls http://localhost:5108 2>&1 | sed -u 's/^/[api] /' &
npm --prefix frontend run dev 2>&1 | sed -u 's/^/[web] /' &
wait
