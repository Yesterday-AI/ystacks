---
name: skill-creator
description: Meta-skill for creating new agent skills. Provides structure, templates, quality checklist, and best practices per agentskills.io spec. Use when building, reviewing, or improving skills.
metadata:
  author: ManniTheRaccoon
  version: "1.1"
  category: platform
compatibility: Any agent with file write access.
---

# Skill Creator 🛠️✨

Meta-skill for building high-quality agent skills. Ensures consistency, completeness, and shareability across the Yesterday agent fleet.

## When to Use

- Creating a **new skill** from scratch
- **Reviewing** an existing skill for completeness
- **Onboarding** a new agent to the skills system

## agentskills.io Specification

We follow the **agentskills.io** open format (https://agentskills.io/specification.md).
Key rules from the spec:

### Directory Structure

```
skill-name/
├── SKILL.md              # Required -- YAML frontmatter + markdown instructions
├── scripts/              # Optional -- executable code agents can run
├── references/           # Optional -- additional docs loaded on demand
└── assets/               # Optional -- templates, images, data files
```

In our repo, skills live under `skills/<category>/<skill-name>/`.

### SKILL.md Frontmatter (Required)

```yaml
---
name: my-skill            # Required. lowercase, hyphens only, 1-64 chars
                          # MUST match parent directory name
description: >            # Required. Max 1024 chars.
  What this does AND when to use it. Include keywords for discovery.
license: Apache-2.0       # Optional
compatibility: >          # Optional. Max 500 chars. Env requirements.
  Requires curl, jq, and a FooBar API key.
metadata:                 # Optional. Arbitrary key-value pairs.
  author: AgentName
  version: "1.0"
allowed-tools: Bash(git:*) Read  # Optional, experimental.
---
```

### Naming Rules
- Lowercase alphanumeric + hyphens only (`a-z`, `0-9`, `-`)
- No leading/trailing hyphens, no consecutive hyphens (`--`)
- Directory name MUST match `name` field

### Progressive Disclosure (Token Budget)
1. **Metadata** (~100 tokens): `name` + `description` loaded at startup for ALL skills
2. **Instructions** (<5000 tokens recommended): Full SKILL.md body loaded on activation
3. **Resources** (on demand): `scripts/`, `references/`, `assets/` loaded only when needed

Keep SKILL.md under **500 lines**. Move detailed reference material to separate files.

### File References
Use relative paths from skill root:
```markdown
See [the reference guide](references/REFERENCE.md) for details.
Run: scripts/extract.py
```
Keep references one level deep. Avoid deeply nested chains.

### Validation
```bash
skills-ref validate ./my-skill
```
(Via https://github.com/agentskills/agentskills/tree/main/skills-ref)

### Template

A blank skill template is available at:
```
references/skill-template.md
```

Copy it, fill it in, and follow the checklist below.

## Quality Checklist ✅

Before shipping a skill, verify:

### Structure
- [ ] YAML frontmatter with name, description, metadata, compatibility
- [ ] Clear "When to Use" section
- [ ] Actionable instructions (not just theory)
- [ ] Scripts are executable (`chmod +x`)

### Content
- [ ] **Document your discoveries** -- If you found an undocumented endpoint, trick, or workaround, write it down. Future agents can't read your mind.
- [ ] **Include gotchas** -- What broke when you first tried? UUID format? Auth quirks? Timeouts? Save others the pain.
- [ ] **Provide introspection hints** -- Spec URLs, debug endpoints, health checks. Anything that helps an agent self-diagnose.
- [ ] **Working examples** -- Not theoretical. Copy-paste-run examples that actually work.
- [ ] **Setup instructions** -- How to get the API key, install deps, configure auth. Don't assume anything.

### Quality
- [ ] **Tested** -- You ran it. It worked. Say so.
- [ ] **Self-contained** -- An agent reading only this SKILL.md can use it without asking anyone.
- [ ] **No secrets in code** -- Keys in env vars or secret files, never hardcoded.
- [ ] **References included** -- API specs, OpenAPI JSON, relevant docs → `references/` dir.

## Anti-Patterns 🚫

### 1. THE_PHANTOM_EDIT
- **What:** You "document" something but forget the crucial detail that made it work.
- **Example:** Writing an API skill but not mentioning the undocumented `/spec.json` endpoint you used to understand the API.
- **Fix:** After building a skill, ask yourself: "If I woke up with amnesia, could I rebuild this from the SKILL.md alone?"

### 2. SETUP_HANDWAVE
- **What:** "Get an API key" without saying WHERE or HOW.
- **Fix:** Exact URL, exact menu path, exact steps. Screenshots if possible.

### 3. WORKS_ON_MY_MACHINE
- **What:** Script works because you have a specific env var or tool installed, but you don't document it.
- **Fix:** `compatibility` field in frontmatter. Required tools in Setup section.

### 4. THEORY_WITHOUT_PRACTICE
- **What:** Long explanations without a single runnable example.
- **Fix:** Every section gets a code block. If it can't be demonstrated, it's not a skill -- it's an essay.

## Workflow

> ⚠️ **Always work in the `-dev` worktree!**
> If you use `openclaw-skill-import`, your stable copy (`agentic-foundation/`) is symlinked into OpenClaw.
> Editing there pollutes your agent context with WIP changes.
> See the `openclaw-skill-import` skill for the full worktree setup.

1. **Work in dev:** `cd <workspace>/agentic-foundation-dev`
2. **Create branch:** `git checkout -b feat/<skill-name>-skill`
3. **Copy template:** `references/skill-template.md` → `skills/<category>/<skill-name>/SKILL.md`
4. **Build & test** the skill
5. **Run checklist** (above)
6. **Update Catalog:** Run `skills/skill-creator/scripts/update-catalog.sh` to refresh `CATALOG.md`
7. **Commit & PR** to `main`
8. **After merge:** `git pull` in stable copy → skills auto-update via symlinks

## Tips

- **Category choice:** `engineering` (code/APIs), `workflow` (processes/meta), `research` (search/analysis), `ops` (infra/deploy)
- **Naming:** lowercase, kebab-case (`my-cool-skill`, not `MyCoolSkill`)
- **Version bump:** Increment when changing behavior, not just docs
- **Cross-reference:** If your skill depends on another, mention it in `compatibility`

---

*"If you found it the hard way, document it the easy way."* 🦝
