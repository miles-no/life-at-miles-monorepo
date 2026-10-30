# Life at Miles monorepo

Umbrella repo for Life at Miles, using git submodules.

| Path | Repo | Description |
| --- | --- | --- |
| `frontend/` | [miles-no/life-at-miles](https://github.com/miles-no/life-at-miles) | Web app (React Router, TypeScript) |
| `backend/` | [miles-no/LifeAtMiles.Backend](https://github.com/miles-no/LifeAtMiles.Backend) | API (C#) |

## Getting started

Prerequisites: git, Docker (or Podman), .NET 10 SDK, Node.

```bash
git clone --recurse-submodules https://github.com/miles-no/life-at-miles-monorepo.git
cd life-at-miles-monorepo
./setup.sh   # one-time: config, database, dependencies
./dev.sh     # starts Postgres, API (:5108) and frontend (:5173)
```

Login needs `AZURE_CLIENT_SECRET` in `frontend/.env.local` (ask a maintainer, see `frontend/README.md`).

## Updating submodules

```bash
git submodule update --remote --merge   # pull latest `dev` of each submodule
git add frontend backend && git commit -m "Bump submodules"
```

Work inside a submodule as in any normal repo (commit/push there), then bump the pointer here.
