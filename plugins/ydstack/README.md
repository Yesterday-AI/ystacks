# ydstack

Yesterday Daily Stack -- generic productivity, creative, and knowledge skills for daily work.

**Status:** Phase 3 of the agentic-foundation -> ystacks migration (2026-04-26). 5 skills migrated; using-github landed earlier.

## Scope

Skills that are useful in day-to-day work and do NOT require `.ytstack/` project state. Engineering-focused skills belong in `ytstack` (engineering OS); autonomous-agent skills belong in `yastack`; consulting workflows belong in `ycstack`.

## Skills shipped (6)

| Skill | Purpose |
|---|---|
| `exa-search-api` | Semantic web search via Exa AI |
| `excalidraw-diagram` | Hand-drawn diagrams as Excalidraw JSON |
| `slack-best-practices` | Slack formatting + communication etiquette |
| `using-github` | GitHub interaction policies |
| `web-scraper` | Tiered web scraping (lightweight fetch -> full browser) |
| `x-reader` | Twitter/X reader with login-wall + JS handling |

## Cross-marketplace plugins (7, auto-pulled via plugin.json)

| Plugin | Purpose |
|---|---|
| [creative-productivity](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/creative-productivity) | Deliverables orchestrator (excalidraw + miro + reveal/marp + draw.io) |
| [figma-console-mcp](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/figma-console-mcp) | Figma + FigJam + Slides automation |
| [miro-board](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/miro-board) | Miro MCP client |
| [para-memory-files](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/para-memory-files) | PARA-method agent memory |
| [skill-creator](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/skill-creator) | Meta-skill for creating new skills |
| [voxtral-tts-api](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/voxtral-tts-api) | Mistral Voxtral TTS |
| [vrr-efa-api](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/vrr-efa-api) | VRR regional transit (Germany) |

## Install

```bash
/plugin marketplace add Yesterday-AI/ystacks
/plugin install ydstack@ystacks
```

Skills appear under `/ydstack:<skill-name>`.
