# Agent guidance

Umbrella repo for Life at Miles: `frontend/` (React Router, TypeScript) and `backend/` (C# API) are git submodules. See `README.md` for setup (`./setup.sh`, `./dev.sh`). Each submodule has its own `CLAUDE.md`; work inside a submodule as in any normal repo and open PRs against that repo, not this one.

## Brand

For anything that should look or sound like Miles (UI, colours, type, logo, icons, copy), use the `miles-brand` skill. It is the `miles-no/brand` repo, vendored as a submodule at `.claude/skills/miles-brand`; the brand guide PDF inside it outranks the restated docs.

## Colour contrast: default to APCA

Judge text legibility with **APCA** (Lc, the WCAG 3 draft model), not just the WCAG 2.x ratio. WCAG 2.x says black on the brand red `#ff303b` is fine (5.7:1) but APCA scores it Lc 42, and it reads poorly; white on that red is 3.7:1 but Lc 68. Neither model alone is enough.

- **APCA first.** Targets by size and weight: Lc 75 for body text (under about 18px regular), Lc 60 for large or bold text, Lc 45 for headlines of 36px and up. Use the absolute value of Lc; polarity does not matter.
- **WCAG 2.x as a floor.** Still meet AA (4.5:1 text, 3:1 large text) because axe and legal requirements use it. A pair must pass both, or you name the exception.
- **axe is not enough.** It only checks WCAG 2.x, and anything over a gradient, image or shadow lands in its `incomplete` bucket, not `violations`. Compute APCA from each text element's computed colour and its effective (composited) background, in light and dark.
- **Brand rule:** the Miles brand reserves solid bright-red surfaces for large text. Small text (badges, chips, buttons at 14px) does not go on `#ff303b`. Use the red tint with burgundy text, or the darker error red `#c80000` with white (6:1, Lc 83).
- **Muted text** is `text-base-content/70` at the faintest. Do not use `/50` or `/60`, and DaisyUI's own 50-60% mutes (`.stat-title`, `.label`, table heads, inactive tabs) are overridden in `frontend/app/styles/global.css`.
- Check both themes (`miles-light`, `miles-dark`) before saying contrast is fixed, and say what you measured and how, not just "passes".
- Disabled controls and deliberately dimmed content (for example a cancelled event card) may be below target; call them out rather than hiding them.
