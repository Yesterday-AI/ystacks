# ystacks -- Contributor Guidelines

Read this before modifying anything in this repo.

## What this repo is

Yesterday's PUBLIC Claude Code plugin catalog. Lists generic-tauglich plugins -- those without Yesterday-infra dependencies. The only meaningful operational file is `.claude-plugin/marketplace.json`.

ystacks does NOT contain plugin source code (with one exception: the `plugins/ydstack/` subdir). Plugins live in their own `Yesterday-AI/<name>` repos and are referenced via `source: { source: "github", repo: "..." }`. To change a plugin's behavior, open a PR against the plugin's own repo, not here.

The companion catalog [`Yesterday-AI/ystacks-internal`](https://github.com/Yesterday-AI/ystacks-internal) (private) hosts internal-only plugins and bundle plugins that compose public + internal via cross-marketplace dependencies.

## If you are an AI agent

Stop. Read this section before acting.

This repo's job is two things:
1. List public plugins via `marketplace.json`.
2. Host `plugins/ydstack/` (skill collection that shares ystacks's lifecycle).

The temptation is to "improve" it -- add scripts, add automation, host more plugins as subdirs. Resist it. Per `.ytstack/DECISIONS.md`, plugins with their own methodology / lifecycle / DECISIONS history live in own repos.

Before opening a PR you MUST:

1. Confirm the change touches `marketplace.json`, `plugins/ydstack/`, or surrounding docs -- NOT plugin source code from other plugins.
2. Validate the JSON parses (`jq . .claude-plugin/marketplace.json > /dev/null`).
3. If adding a plugin entry: verify the plugin has NO Yesterday-infra dependencies (otherwise it belongs in ystacks-internal).
4. Show the human the full proposed diff before any git commit.

## Hard rules

### No Yesterday-infra-dependent plugins

If a plugin needs Yesterday-internal services (clawrag, llm-gateway, paperclip, agent-services, openclaw, cloud, etc.), it does NOT belong in this catalog -- it belongs in ystacks-internal. ystacks stays public-tauglich.

### Never modify a listed plugin from this repo

If a plugin (other than the local `ydstack` subdir) needs changes, open a PR against its own repo. ystacks's role is to list, not to host (with the ydstack exception).

### marketplace.json is the source of truth

Every section in README / CONTRIBUTING that mentions a listed plugin must be derivable from `marketplace.json`. If you add a plugin, update both. If they disagree, marketplace.json wins.

### One plugin entry per PR

Adding two plugins in one PR makes review harder and rollback messier. Split.

### Atomic commits

One logical change per commit.

## Commit message format

- Add plugin: `add <plugin-name> to catalog`
- Bump pin: `bump <plugin-name> to <version-or-sha>`
- Remove: `remove <plugin-name> from catalog`
- ydstack changes: `ydstack: <what>`
- Docs: `docs: <what>`
- Infra: `chore: <what>`

## When in doubt

Ask the human. ystacks is deliberately small; if a change feels architecturally significant, it probably belongs in a plugin repo or in ystacks-internal, not here.
