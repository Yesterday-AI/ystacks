<div align="center">
  <img src="assets/ystacks-logo.svg" width="88" alt="ystacks" />

  <h1>ystacks</h1>

  <p><em>Yesterday's PUBLIC Claude Code plugin catalog. Public-tauglich plugins, no Yesterday-infra deps.</em></p>

  <p>
    A thin marketplace catalog that lists Yesterday's PUBLIC Claude Code plugins. Generic-tauglich means: no dependency on Yesterday infrastructure -- any team can install and use these plugins.
  </p>

  <p>
    <a href="./LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue"></a>
    <img alt="Claude Code" src="https://img.shields.io/badge/Claude%20Code-marketplace-0A0A0A">
    <img alt="visibility" src="https://img.shields.io/badge/visibility-public-22C55E">
  </p>

</div>

---

## Install

Add the marketplace:

```bash
/plugin marketplace add Yesterday-AI/ystacks
```

Browse and install interactively:

```bash
/plugin
```

Or install a plugin directly:

```bash
/plugin install yastack@ystacks
/plugin install yopstack@ystacks
/plugin install ydstack@ystacks
```

No auth required -- ystacks is public.

## What's in the catalog

12 plugins listed here (4 stacks + 8 own-plugins) + 1 planned (ytstack, currently private). Total: **5 stacks** in the family.

### Stacks

| Plugin | Source | Purpose |
|---|---|---|
| [yastack](https://github.com/Yesterday-AI/yastack) | github `Yesterday-AI/yastack` | Agent core -- 14 generic skills for AI agents at [Levels-of-AGI](https://arxiv.org/html/2311.02462v5#S6) 3-4 (Collaborator / Expert). Imports creative-productivity + para-memory-files + skill-creator. |
| [yopstack](https://github.com/Yesterday-AI/yopstack) | github `Yesterday-AI/yopstack` | Ops core -- 1 skill shipped (`opentofu`); 3 gstack skills pending vendor (`land-and-deploy`, `canary`, `setup-deploy`). Imports skill-creator. |
| [ydstack](./plugins/ydstack) | local subdir `./plugins/ydstack` | Daily-work -- 6 skills (exa-search-api, excalidraw-diagram, slack-best-practices, using-github, web-scraper, x-reader) + 7 cross-mp imports (creative-productivity, figma-console-mcp, miro-board, para-memory-files, skill-creator, voxtral-tts-api, vrr-efa-api). |
| [ycstack](./plugins/ycstack) | local subdir `./plugins/ycstack` | Consulting placeholder -- no skills yet. Yesterday-team consulting skills live in private `ycstack-internal`. Imports skill-creator. |
| [ytstack](https://github.com/Yesterday-AI/ytstack) | github `Yesterday-AI/ytstack` | Engineering OS for AI coding agents -- 21 skills (project-OS lifecycle + curated wrappers). **Planned for ystacks** -- currently private + cross-listed in `ystacks-internal`; will be listed here once it flips public. Imports skill-creator + web-design + yesterday-brand. |

### Own-plugins (cross-imported by stacks)

| Plugin | Source | Imported by |
|---|---|---|
| [creative-productivity](./plugins/creative-productivity) | local subdir | yastack, ydstack |
| [figma-console-mcp](./plugins/figma-console-mcp) | local subdir | ydstack |
| [miro-board](./plugins/miro-board) | local subdir | ydstack |
| [para-memory-files](./plugins/para-memory-files) | local subdir | yastack, ydstack |
| [skill-creator](./plugins/skill-creator) | local subdir | all 5 stacks |
| [voxtral-tts-api](./plugins/voxtral-tts-api) | local subdir | ydstack |
| [vrr-efa-api](./plugins/vrr-efa-api) | local subdir | ydstack |
| [web-design](./plugins/web-design) | local subdir | ytstack |

## Companion: ystacks-internal (private)

Yesterday-team has a separate private catalog with internal-only plugins and Yesterday-bundle plugins (`-internal` suffix) that compose public plugins with Yesterday-infra service-clients. Org members can request access via Yesterday-AI.

External users do not need it; ystacks alone provides the public Yesterday plugin family.

## Why two catalogs

Mixed-visibility marketplaces (public catalog listing private plugins) leak plugin names + descriptions while users cannot install. The 2026-04-25 architecture session split into two catalogs, one per visibility:

- **ystacks** (this repo, public) -- only plugins that work without Yesterday-infra.
- A private companion catalog exists for Yesterday-team-internal plugins (request access via Yesterday-AI).

Each plugin has its own repo with its own `.ytstack/DECISIONS.md` for per-plugin architectural choices.

## Adding a plugin

A plugin earns a listing here if:

1. Lives in its own `Yesterday-AI/<name>` repo (or `./plugins/<name>/` subdir if it's a skill collection that shares ystacks's lifecycle).
2. Has a tagged release with a valid `.claude-plugin/plugin.json`.
3. Has **no Yesterday-infra dependencies** (otherwise it belongs in the private companion catalog).
4. Follows Yesterday's plugin standards (see [ytstack/CONTRIBUTING.md](https://github.com/Yesterday-AI/ytstack/blob/main/CONTRIBUTING.md) as the reference).

See [CONTRIBUTING.md](./CONTRIBUTING.md) for the PR workflow.

## Repo layout

```
ystacks/
├── .claude-plugin/
│   └── marketplace.json     the public catalog (12 plugins)
├── plugins/
│   ├── ydstack/             daily-work skill collection (6 skills + 7 cross-mp imports)
│   ├── ycstack/             consulting placeholder
│   ├── creative-productivity/   own-plugin (deliverables orchestrator)
│   ├── figma-console-mcp/   own-plugin (Figma MCP)
│   ├── miro-board/          own-plugin (Miro MCP)
│   ├── para-memory-files/   own-plugin (PARA agent memory)
│   ├── skill-creator/       own-plugin (meta-skill, imported by all 5 stacks)
│   ├── voxtral-tts-api/     own-plugin (Mistral TTS)
│   ├── vrr-efa-api/         own-plugin (DE regional transit)
│   └── web-design/          own-plugin (frontend craft, imported by ytstack)
├── README.md                this file
├── CLAUDE.md                contributor guide for AI agents
├── CONTRIBUTING.md          contributor guide for humans
├── LICENSE                  MIT
├── NOTICE                   attribution
└── .gitignore
```

## Status

**Migration complete (2026-04-26).** 12 plugins listed here: 4 stacks (yastack, yopstack, ydstack, ycstack) + 8 own-plugins (creative-productivity, figma-console-mcp, miro-board, para-memory-files, skill-creator, voxtral-tts-api, vrr-efa-api, web-design). Skills migrated from `agentic-foundation` per [MIGRATION-TRIAGE.md v8 FROZEN](https://github.com/Yesterday-AI/agentic-foundation/blob/main/MIGRATION-TRIAGE.md). yopstack still pending the gstack vendor subtree for `land-and-deploy` / `canary` / `setup-deploy`. **5th stack planned:** ytstack (engineering OS) lives in [`Yesterday-AI/ytstack`](https://github.com/Yesterday-AI/ytstack), currently private + cross-listed in `ystacks-internal`; will be listed here once it flips public.

## License

MIT. See [LICENSE](./LICENSE). Plugins listed here carry their own licenses.

---

Maintained by [Yesterday](https://github.com/Yesterday-AI).
