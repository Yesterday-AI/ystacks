# ydstack-extras

Yesterday Daily Stack -- **extras tier**. Optional integrations that need external SaaS accounts or API keys.

## Scope

Wrapper bundle (no own skills). Installs Daily-Stack add-ons that aren't useful without an external account / key, kept out of `ydstack` core so users without those services don't see broken integrations.

## Cross-marketplace plugins (4, auto-pulled via plugin.json)

| Plugin | Purpose | Requires |
|---|---|---|
| [figma-console-mcp](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/figma-console-mcp) | Figma + FigJam + Slides automation | Figma account + token |
| [miro-board](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/miro-board) | Miro MCP client | Miro account + token |
| [voxtral-tts-api](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/voxtral-tts-api) | Mistral Voxtral TTS | Mistral API key |
| [vrr-efa-api](https://github.com/Yesterday-AI/ystacks/tree/main/plugins/vrr-efa-api) | VRR regional transit (Germany) | none -- but only useful in DE/NRW |

## Install

```bash
/plugin marketplace add Yesterday-AI/ystacks
/plugin install ydstack-extras@ystacks
```

Typically alongside `ydstack` (core); `ydstack-extras` alone works too if you only want these integrations.
