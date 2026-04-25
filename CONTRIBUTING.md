# Contributing to ystacks

ystacks is Yesterday's public Claude Code plugin catalog. Listed plugins must be generic-tauglich (no Yesterday-infra deps). The companion [`Yesterday-AI/ystacks-internal`](https://github.com/Yesterday-AI/ystacks-internal) (private) hosts the rest.

## Philosophy

Catalog repos rot when they accumulate plugin-side concerns. Keep this repo to its two jobs: listing public plugins, and hosting `plugins/ydstack/` (a skill collection that shares ystacks's lifecycle).

**Belongs in ystacks:**

- Adding / removing a plugin entry in `marketplace.json`
- Bumping a plugin's pinned version or commit
- Updating `plugins/ydstack/` skill content
- Fixing typos or errors in catalog metadata
- Updating README to reflect catalog changes

**Does NOT belong:**

- Plugin source code (other than `plugins/ydstack/`)
- Yesterday-infra-dependent plugins (those go in ystacks-internal)
- Build scripts, test runners, CI workflows beyond the catalog itself

## Adding a plugin

A plugin earns a listing if:

1. Lives in its own `Yesterday-AI/<name>` repo (or `./plugins/<name>/` subdir if it's a skill collection that fits ystacks's lifecycle).
2. Has a valid `.claude-plugin/plugin.json`.
3. Has **no Yesterday-infra dependencies** (otherwise it belongs in ystacks-internal).
4. Follows Yesterday's plugin standards (see [ytstack/CONTRIBUTING.md](https://github.com/Yesterday-AI/ytstack/blob/main/CONTRIBUTING.md) as the reference).

To add an entry:

1. Open a PR adding a block to the `plugins` array in `marketplace.json`:
   ```json
   {
     "name": "<plugin-name>",
     "description": "<one-line purpose>",
     "source": {
       "source": "github",
       "repo": "Yesterday-AI/<plugin-name>"
     },
     "author": {
       "name": "Yesterday",
       "url": "https://github.com/Yesterday-AI"
     },
     "keywords": ["claude-code", "yesterday-ai", "..."]
   }
   ```
2. Update the catalog table in `README.md`.

## Removing a plugin

Removing breaks installs for current users. Open an issue first describing why, get human signoff, then PR.

## Pinning versions

By default, a plugin entry tracks the upstream's default branch -- new commits land automatically. For more control:

- `"commit": "<sha>"` -- immutable reference
- `"ref": "<branch-or-tag>"` -- track a specific branch or tag
- Tag-based semver resolution requires the upstream plugin to follow the `{plugin-name}--v{version}` tag convention; see [Claude Code's plugin-dependencies docs](https://code.claude.com/docs/en/plugin-dependencies)

## Commit message format

- Add plugin: `add <plugin-name> to catalog`
- Bump pin: `bump <plugin-name> to <version-or-sha>`
- Remove: `remove <plugin-name> from catalog`
- ydstack changes: `ydstack: <what>`
- Docs: `docs: <what>`
- Infra: `chore: <what>`

## Atomic commits

One logical change per commit.

## Release cadence

ystacks itself is unversioned. Each plugin in the catalog has its own version line. The catalog's "release" is git `main`.

## Getting help

- Read [CLAUDE.md](./CLAUDE.md) for agent-specific guidance.
- Read [README.md](./README.md) for the catalog overview.
- For plugin-specific issues, open an issue against the plugin's own repo (not here).
