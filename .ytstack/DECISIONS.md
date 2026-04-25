# Decisions

Append-only architectural and product decisions for ystacks (the public catalog repo). Never rewrite past entries. If a decision is reversed, add a new entry that supersedes.

Format for each entry:

## YYYY-MM-DD: \<Short title\>

**Context:** what forced the decision
**Options considered:** A, B, C
**Chose:** selected option
**Reason:** why
**Supersedes:** link to earlier entry if this reverses a prior decision

---

## 2026-04-25: ystacks created as PUBLIC catalog (rename + new-create operation)

**Context:** Earlier 2026-04-25 architecture session locked the Yesterday plugin landscape as a hybrid monorepo + catalog model: a single private `Yesterday-AI/ystacks` repo containing both the marketplace catalog AND some plugins as `plugins/<name>/` subdirs (ydstack, yastack-internal). User reviewed this and identified the visibility-mix problem: a public marketplace listing private plugins leaks plugin names + descriptions to external users who cannot install them. Plus: per-plugin DECISIONS history is load-bearing; bundle plugins and skill collections that live as subdirs cannot easily have their own DECISIONS.

**Options considered:**
- A) Stay with hybrid private marketplace (mixed visibility) -- leaks names of internal plugins.
- B) Migration: extract everything from the private monorepo into its own repo + create a new public marketplace -- big content move, complex.
- C) Rename + new-create: rename existing `Yesterday-AI/ystacks` to `Yesterday-AI/ystacks-internal`, scaffold a new `Yesterday-AI/ystacks` (public) from scratch. Simpler than B because no content migration -- old repo keeps its content, new repo starts empty + receives only public-tauglich subdirs (today: ydstack moves over).

**Chose:** C (rename + new-create).

**Reason:** Avoids big content-migration headaches. Old repo keeps its history + scope (now scope-flipped to private-internal-only). New repo starts clean, can be populated incrementally. Per-plugin DECISIONS continue to live in own plugin repos; subdir plugins (ydstack here) can have minimal `.ytstack/` if needed. yastack-internal and yopstack-internal stay as subdirs in ystacks-internal because they're wrapper bundles (deps-array-only) -- no real architectural-decision surface.

**How to apply:**
- `Yesterday-AI/ystacks` (old, private monorepo+catalog) -> renamed to `Yesterday-AI/ystacks-internal` 2026-04-25 via `gh repo rename`.
- `Yesterday-AI/ystacks` (new, public catalog) -> scaffolded 2026-04-25 with `.claude-plugin/marketplace.json` + plugins/ydstack subdir + own minimal `.ytstack/`.
- `plugins/ydstack/` moved from ystacks-internal repo to new ystacks repo (subdir transplant).
- ytstack stays in own repo (private vorerst, not listed in public ystacks until flipped).
- Cross-marketplace deps: ystacks-internal/marketplace.json declares `allowCrossMarketplaceDependenciesOn: ["ystacks"]` so yastack-internal/yopstack-internal (in ystacks-internal) can dep on yastack/yopstack (in ystacks).

**Supersedes:** the hybrid monorepo + catalog model from earlier 2026-04-25 (in old ystacks DECISIONS, which now lives at ystacks-internal). The "monorepo + catalog hybrid" wording in ytstack DECISIONS 2026-04-25 "Marketplace consolidates on Yesterday-AI/ystacks" is partially superseded -- ytstack DECISIONS gets a separate supersede entry naming this split.

---

## 2026-04-25: ydstack stays as monorepo subdir (skill-collection exception)

**Context:** The new architecture says "each plugin gets its own repo so it can have its own `.ytstack/DECISIONS.md`". ydstack is a skill collection of 14 generic productivity skills. Question: does ydstack need its own repo too, or can it stay as `plugins/ydstack/` subdir?

**Options considered:**
- A) Extract ydstack to own repo `Yesterday-AI/ydstack` -- consistent with "each plugin own repo" rule, but heavy for a skill collection with no real DECISIONS surface.
- B) ydstack stays as subdir in ystacks -- skill collections don't have architectural-decisions; the DECISIONS surface is captured in ystacks itself (where ydstack lives).

**Chose:** B (subdir).

**Reason:** ydstack has no methodology / hooks / agents code -- it's just SKILL.md files. Architectural decisions about "which skills land in ydstack" are catalog-level decisions (which is what ystacks itself owns). Extracting ydstack to own repo would create a near-empty `.ytstack/` with no content to log. The "own repo for own DECISIONS" rule applies to plugins with real architectural surface (ytstack, yastack, yopstack -- all of which have methodology + skills + framework choices). Wrapper bundles (yastack-internal, yopstack-internal) and skill collections (ydstack) don't need it.

**How to apply:**
- `plugins/ydstack/` lives in ystacks repo (this repo).
- ydstack-specific architectural decisions (e.g. "which niche-vertical skills are in scope") get logged in ystacks `.ytstack/DECISIONS.md` (here) when they arise, not in a separate ydstack DECISIONS.
- If ydstack ever grows real methodology / framework code, revisit -- might warrant own repo then.
