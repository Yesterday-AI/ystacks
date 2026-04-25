---
name: ystacks
slug: ystacks
created: 2026-04-25T00:00:00Z
updated: 2026-04-25T00:00:00Z
---

# ystacks

**One-liner:** Yesterday's PUBLIC Claude Code plugin catalog. Generic-tauglich plugins (no Yesterday-infra deps), companion to the private `ystacks-internal` catalog.

## What this project is

A two-job repo:
1. **Catalog:** `.claude-plugin/marketplace.json` lists Yesterday's public Claude Code plugins. External users add this marketplace to discover and install.
2. **Plugin host:** `plugins/ydstack/` is a skill collection (daily-work productivity skills) that shares ystacks's lifecycle and lives as a monorepo subdir rather than its own repo.

Companion: [`Yesterday-AI/ystacks-internal`](https://github.com/Yesterday-AI/ystacks-internal) hosts Yesterday-team-internal plugins (service clients) and bundle plugins (yastack-internal, yopstack-internal) that compose public + internal via cross-marketplace dependencies.

## Why it exists

Created 2026-04-25 from a rename + scaffold operation. The previous `Yesterday-AI/ystacks` repo (private, monorepo + catalog hybrid containing ydstack + yastack-internal) was renamed to `Yesterday-AI/ystacks-internal` to match its private scope. This new `Yesterday-AI/ystacks` repo was scaffolded as the public-facing companion -- visibility-clean separation, no leakage of internal plugin names + descriptions to external users.

Background: the 2026-04-25 plugin-landscape session locked five-plus-N plugins under Yesterday's `y{c}stack` naming convention. Visibility-mix in a single marketplace is unsaubere UX; splitting catalogs by visibility is cleaner. See `.ytstack/DECISIONS.md` for the locked decisions.

## Scope

- **In scope:** marketplace.json maintenance (public listings); ydstack subdir (skill collection lifecycle); README documentation of the catalog + add-plugin workflow.
- **Out of scope:** plugin source code for plugins that have own repos (yastack, yopstack, ytstack-when-public). Yesterday-infra-dependent plugins (those live in ystacks-internal). Modify those at their respective repos.
- **Non-goals:** mixed-visibility listing; bundle plugins (those live in ystacks-internal); skill methodology / decisions for the listed plugins (those live in their own repos' `.ytstack/`).

## Success criteria

- An external user runs `/plugin marketplace add Yesterday-AI/ystacks` and sees a clean catalog of public-installable plugins. No 404 / auth errors on any listed plugin.
- Each listed plugin has its own `.claude-plugin/plugin.json` and is installable without Yesterday-infra access.
- ydstack subdir lives here naturally because it shares ystacks's lifecycle (no own DECISIONS history needed for a skill collection).

## Current status

**v0.1.0 -- public catalog scaffold (2026-04-25).** Three plugins listed: `yastack` (own public repo, scaffold), `yopstack` (own public repo, scaffold, NEW this session), `ydstack` (subdir, moved from old ystacks repo). `ytstack` is currently private and not listed here -- when it flips public, it will be added.

Reactive mode: no active milestones. Catalog updates land per plugin add / remove / version-bump.
