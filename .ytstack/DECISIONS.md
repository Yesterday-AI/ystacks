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

---

## 2026-04-29: ydstack tier split (core / extras)

**Context:** ydstack `plugin.json` declared 7 hard-deps on sibling plugins (creative-productivity, figma-console-mcp, miro-board, para-memory-files, skill-creator, voxtral-tts-api, vrr-efa-api). A user installed ydstack and immediately hit a dependency error because `figma-console-mcp` was disabled in their environment. The plugin loader treats hard-deps as all-or-nothing -- one disabled extras-style integration breaks the whole bundle. Mixed shape inside the deps list: core utilities (creative-productivity, para-memory-files, skill-creator) require nothing external; extras (figma, miro, voxtral, vrr) only function with SaaS accounts/keys (vrr is region-specific to DE/NRW).

**Options considered:**
- A) Keep flat hard-deps. Document that users must enable all 7. Simplest, but the failure mode (one disabled extras → ydstack broken) is exactly what the user just hit.
- B) Make extras "optional" / "recommended". The Claude Code plugin spec does not currently expose an optional-deps field that the marketplace honors. Would require a spec change or a soft-recommendation convention that nothing enforces.
- C) Split into two plugin entries: `ydstack` (core, hard-deps OK) and `ydstack-extras` (wrapper bundle for the SaaS-bound siblings). Users opt into extras explicitly. Costs one extra marketplace entry and one extra wrapper plugin dir.

**Chose:** C (tier split into ydstack + ydstack-extras).

**Reason:** Solves the user's failure case directly: installing core no longer requires Figma/Miro/Voxtral/VRR to be enabled. Naming follows Linux/Python convention (`-extras`) -- explicit about "optional add-ons needing external accounts" rather than the more ambiguous `-extended`. Wrapper-plugin pattern is already established in the org (yastack-internal, yopstack-internal in ystacks-internal). Keeps the catalog discoverable: `/plugin install ydstack-extras@ystacks` is one obvious step for users who want them.

**How to apply:**
- `plugins/ydstack/.claude-plugin/plugin.json` deps reduced from 7 to 3: creative-productivity, para-memory-files, skill-creator. Version bumped 0.0.1 -> 0.0.2.
- `plugins/ydstack-extras/.claude-plugin/plugin.json` is a new wrapper bundle (no own skills) with deps: figma-console-mcp, miro-board, voxtral-tts-api, vrr-efa-api.
- `marketplace.json` lists both. ydstack description updated to mention the core/extras split + point at ydstack-extras.
- README, ydstack/README.md, STATE.md updated for new counts (13 plugins listed; ydstack 6 skills + 3 imports; ydstack-extras 0 skills + 4 imports).
- **Open consistency question:** ydstack still ships `exa-search-api` and `x-reader` as embedded skills, both of which need external keys/accounts. By the same tier logic those would also belong in extras. Deferred per user 2026-04-29 ("die anderen weiss ich noch nicht") -- only the 4 sibling-plugin extras moved in this PR. Revisit if/when user decides to extend the tier model to embedded skills.
