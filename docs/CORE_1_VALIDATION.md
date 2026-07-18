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
- Diagnosis, revision, privacy, workspace-mismatch, and reflection cases are present.
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

### 4. Repository inspection displaced the learning cycle

The first desktop runtime test successfully loaded `$novome-coach`, but the model searched the currently open knowledge-base workspace and returned a repository-location troubleshooting question. It did not produce the required four-dimension diagnosis, one micro-lesson, or learner step.

This confirmed installation and explicit invocation, but failed the canonical behavior test.

The skill now requires that the first response:

1. uses the task text before any repository tools;
2. completes the four-dimension diagnosis;
3. teaches exactly one missing skill;
4. asks for one learner action and stops;
5. treats a missing or mismatched workspace as a Context gap rather than a reason to skip coaching.

A dedicated `mismatched_workspace_still_coaches` regression case was added.

## Behavior review

The canonical cycle is internally consistent after the fixes:

1. `$novome-coach` receives a real but weak task.
2. Novome evaluates Goal, Context, Constraints, and Verification before inspecting the workspace.
3. It selects one priority and gives one micro-lesson of at most 80 words.
4. It requests one learner contribution and stops before implementation or repository search.
5. It re-evaluates the contribution.
6. It produces a task brief that marks unknowns and separates learner input from repository evidence.
7. Only then does it inspect the repository and continue the underlying task.
8. It reflects only on evidence visible in the current session.

## Runtime status

Confirmed:

- marketplace installation succeeded;
- the Novome plugin appeared in the ChatGPT desktop app;
- `$novome-coach` was recognized and invoked;
- the skill ran inside a Codex session.

Needs re-test after marketplace upgrade:

- first response follows the required diagnosis → micro-lesson → learner-step structure;
- no workspace inspection occurs before the learner action;
- the canonical task selects Verification as the first priority.

## Manual re-test required

Refresh the Git-backed marketplace snapshot:

```bash
codex plugin marketplace upgrade novome
```

If the installed plugin still uses the prior cached copy, uninstall and reinstall Novome from the Plugins Directory, restart the ChatGPT desktop app, and start a new Codex session.

Run:

```text
$novome-coach

Fix the login bug.
```

Expected first response: a Novome diagnosis of Goal, Context, Constraints, and Verification; one Verification micro-lesson; one request for a concrete `Done when` statement; no repository search or implementation.

After the final accepted version is merged, capture the `/feedback` Session ID required for the Build Week submission.
