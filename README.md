# Life at Miles monorepo

Umbrella repo for Life at Miles, using git submodules.

| Path | Repo | Description |
| --- | --- | --- |
| `frontend/` | [miles-no/life-at-miles](https://github.com/miles-no/life-at-miles) | Web app (React Router, TypeScript) |
| `backend/` | [miles-no/LifeAtMiles.Backend](https://github.com/miles-no/LifeAtMiles.Backend) | API (C#) |

## Getting started

```bash
git clone --recurse-submodules https://github.com/miles-no/life-at-miles-monorepo.git
# or, in an existing clone:
git submodule update --init --recursive
```

## Updating submodules

```bash
git submodule update --remote --merge   # pull latest `dev` of each submodule
git add frontend backend && git commit -m "Bump submodules"
```

Work inside a submodule as in any normal repo (commit/push there), then bump the pointer here.
