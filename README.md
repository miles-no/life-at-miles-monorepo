# Life at Miles monorepo

Umbrella repo for Life at Miles, using git submodules.

| Path | Repo | Description |
| --- | --- | --- |
| `frontend/` | [miles-no/life-at-miles](https://github.com/miles-no/life-at-miles) | Web app (React Router, TypeScript) |
| `backend/` | [miles-no/LifeAtMiles.Backend](https://github.com/miles-no/LifeAtMiles.Backend) | API (C#) |
| `.claude/skills/miles-brand/` | [miles-no/brand](https://github.com/miles-no/brand) | Miles brand skill for coding agents (colours, type, logo, UI theme) |

## Getting started

Prerequisites: git, Docker (or Podman), .NET 10 SDK, Node.

```bash
git clone --recurse-submodules https://github.com/miles-no/life-at-miles-monorepo.git
cd life-at-miles-monorepo
./setup.sh   # one-time: submodules and dependencies
./dev.sh     # starts Postgres, API (:5108) and frontend (:5173)
```

Open http://localhost:5173 and sign in with the **Regular / Servant / Admin** dev-login buttons. No secrets are needed: `dev.sh` supplies placeholder config, and Flowcase, Slack etc. use the backend's no-op clients.

To sign in with real Microsoft accounts or use real integrations, put real values in `frontend/.env.local` / the backend's `appsettings.Development.json` instead (see each repo's README).

## Updating submodules

```bash
git submodule update --remote --merge   # pull latest `dev` of each submodule
git add frontend backend && git commit -m "Bump submodules"
```

Work inside a submodule as in any normal repo (commit/push there), then bump the pointer here.
