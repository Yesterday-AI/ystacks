---
project: ystacks
slug: ystacks
last_updated: 2026-04-25T00:00:00Z
current_milestone: none (reactive mode)
active_slice: none
active_task: none
---

# State

**Status:** Reactive mode -- ystacks does not run in milestones / slices / tasks. Catalog updates land per plugin add / remove / version-bump. Major architectural changes (e.g. multi-marketplace expansion) would warrant a milestone if they ever come up; today there are none.

## Current catalog

| Plugin | Status | Source | In marketplace.json? |
|---|---|---|---|
| yastack | scaffold (installable, no skills yet) | github `Yesterday-AI/yastack` (public) | yes |
| yopstack | scaffold (installable, no skills yet) | github `Yesterday-AI/yopstack` (public, NEW 2026-04-25) | yes |
| ydstack | scaffold (installable, no skills yet) | local `./plugins/ydstack/` (subdir) | yes |

Plus: future listings when ready:
- `ytstack` -- currently private, will be listed once it flips public

## Open follow-ups

- agentic-foundation skill migration: 14 skills -> ydstack, 15 skills -> yastack. Triggers move from "scaffold" to "shipped" for both.
- vendor/gstack subtree-add to yopstack -> wraps land-and-deploy + canary + setup-deploy.
- opentofu migration from yastack to yopstack.
- Watch for ytstack public-flip (then add ytstack entry to marketplace.json).

## Repo metadata (current as of last update)

- **GitHub description:** "Yesterday's PUBLIC Claude Code plugin catalog -- yastack, yopstack, ydstack."
- **GitHub topics:** `claude-code claude-code-plugin claude-code-marketplace plugin-marketplace plugin-catalog yesterday-ai agentic ai-agents ops`
- **Visibility:** public

## Recent changes

- 2026-04-25: scaffolded as new public catalog repo (rename + new-create operation). Old `Yesterday-AI/ystacks` was renamed to `Yesterday-AI/ystacks-internal` (private, internal-only). This new repo started empty and received `plugins/ydstack/` as the only subdir transplant. yastack + yopstack listed via github source. ytstack not yet listed (still private).
- See `.ytstack/DECISIONS.md` "ystacks created as PUBLIC catalog (rename + new-create operation)" for the architectural rationale.

## Next action

Reactive: list ytstack in marketplace.json once it flips public. Otherwise no action queued.

User-side tasks waiting:
1. Push this scaffold to `Yesterday-AI/ystacks` via `gh repo create Yesterday-AI/ystacks --public --source=. --push` (interactive flow).
2. Set GitHub description + topics (text + topics in "Repo metadata" section above).
