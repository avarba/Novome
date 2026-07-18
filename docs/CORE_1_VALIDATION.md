# Core 1 validation report

Date: 2026-07-18

Scope: GitHub issue #1 — validate the smallest installable, instruction-only Novome plugin without adding a website, backend, database, authentication, MCP server, hooks, external profile integrations, analytics, or persistent learner memory.

## Source of truth

Validated against the current official OpenAI documentation:

- https://developers.openai.com/codex/plugins/build
- https://developers.openai.com/codex/plugins
- https://developers.openai.com/codex/skills
- https://developers.openai.com/codex/learn/best-practices

## Format validation

### Plugin manifest

File: `.codex-plugin/plugin.json`

- JSON parses successfully.
- Required plugin identifier, version, description, and `skills` path are present.
- The manifest is the only file stored under `.codex-plugin/`.
- The `skills` path is relative to the plugin root and begins with `./`.
- Empty-site links were replaced with the public GitHub repository until a working landing page exists.
- Optional capability labels were removed because version 0 bundles instructions only and exposes no connector or MCP tools.

### Marketplace

File: `.agents/plugins/marketplace.json`

- JSON parses successfully.
- Required top-level marketplace name, plugin list, install policy, authentication policy, and category are present.
- `source.path` is `./`, which resolves to the repository root from the marketplace root. This is the plugin directory because the manifest is at `./.codex-plugin/plugin.json`.
- The expected source command is:

```bash
codex plugin marketplace add avarba/Novome --ref main
```

### Skill

Files:

- `skills/novome-coach/SKILL.md`
- `skills/novome-coach/agents/openai.yaml`

- SKILL frontmatter contains the required `name` and `description`.
- `openai.yaml` parses successfully.
- `policy.allow_implicit_invocation` is `false`, so `$novome-coach` remains explicit-only.
- The skill is instruction-only and declares no tool dependencies.

### Behavioral evals

File: `evals/cases.yaml`

- YAML parses successfully.
- Nine diagnosis/revision cases and one reflection case are present.
- The evals consistently require one learning priority, learner participation, observable evidence, and no permanent profile.

## Concrete contradictions fixed

### 1. Invented constraints in the canonical demo

The previous demo added `Preserve the public authentication API` and `avoid adding dependencies` even though the learner had not supplied those requirements and the repository had not yet been inspected.

This contradicted both:

- `SKILL.md`: do not invent business requirements; use only stated or repository-derived constraints;
- `evals/cases.yaml`: preserve unknown context as unknown and do not invent constraints.

The demo now marks constraints as not learner-supplied and requires repository evidence before treating anything as a constraint.

### 2. Experience labels without evidence

The previous adaptation section used a separate rule `For beginners`, while the skill prohibits unsupported professional-level labels.

The rule now adapts only to visible task evidence or an explicit request for simpler language. Self-reported experience remains context, not proof.

### 3. Unsupported installation wording

The README now distinguishes supported surfaces:

- ChatGPT desktop app with Codex;
- Codex CLI.

It explicitly states that plugins are not available in Chat mode, the Codex IDE extension, or mobile, and that a new session is required after installation.

## Behavior review

The canonical cycle is internally consistent after the fixes:

1. `$novome-coach` receives a real but weak task.
2. Novome evaluates Goal, Context, Constraints, and Verification.
3. It selects one priority and gives one micro-lesson of at most 80 words.
4. It requests one learner contribution and stops before implementation.
5. It re-evaluates the contribution.
6. It produces a task brief that marks unknowns and separates learner input from repository evidence.
7. It continues the underlying Codex task.
8. It reflects only on evidence visible in the current session.

## Manual verification still required

The following cannot be completed through the GitHub connector and must be performed on a supported Codex surface:

1. Run the marketplace add command in a terminal with Codex CLI.
2. Install Novome from Plugins in the ChatGPT desktop app or `/plugins` in Codex CLI.
3. Start a new session and confirm `$novome-coach` appears.
4. Run the canonical five-minute judge test.
5. Capture the `/feedback` Session ID required for the Build Week submission.

No further design or infrastructure change is required before this manual installation test.
