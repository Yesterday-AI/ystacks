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

| Plugin | Source | Purpose |
|---|---|---|
| [yastack](https://github.com/Yesterday-AI/yastack) | github `Yesterday-AI/yastack` | Agent core -- 15 generic skills for AI agents at [Levels-of-AGI](https://arxiv.org/html/2311.02462v5#S6) 3-4 (Collaborator / Expert). Migrating from [`agentic-foundation`](https://github.com/Yesterday-AI/agentic-foundation). |
| [yopstack](https://github.com/Yesterday-AI/yopstack) | github `Yesterday-AI/yopstack` | Ops core -- 4 skills for provisioning, deployment, and observability (`opentofu`, `land-and-deploy`, `canary`, `setup-deploy`). |
| [ydstack](./plugins/ydstack) | local subdir `./plugins/ydstack` | Daily-work -- 14 skills for human productivity, creative, and knowledge work (excalidraw, PARA memory, scrapers, miro, figma, voxtral, niche verticals). |

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
│   └── marketplace.json     the public catalog
├── plugins/
│   └── ydstack/             daily-work skill collection (subdir)
├── README.md                this file
├── CLAUDE.md                contributor guide for AI agents
├── CONTRIBUTING.md          contributor guide for humans
├── LICENSE                  MIT
├── NOTICE                   attribution
└── .gitignore
```

## Status

**v0.1.0 -- public catalog launch (2026-04-25).** Three plugins listed (yastack, yopstack, ydstack). yastack + yopstack are scaffolds (no skills migrated yet -- pending agentic-foundation + vendor/gstack work). ydstack is also a scaffold. ytstack (engineering OS) lives in [`Yesterday-AI/ytstack`](https://github.com/Yesterday-AI/ytstack) but is currently private; it will be listed here once it goes public.

## License

MIT. See [LICENSE](./LICENSE). Plugins listed here carry their own licenses.

---

Maintained by [Yesterday](https://github.com/Yesterday-AI).
