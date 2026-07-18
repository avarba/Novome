# First Codex task for Novome

Paste the prompt below into a new Codex task connected to `avarba/Novome`.

```text
We are executing GitHub issue #1 in the public repository avarba/Novome.

Goal:
Validate and harden the smallest installable Novome Codex plugin before we build any demo application.

Start by inspecting the entire repository, especially:
- .codex-plugin/plugin.json
- .agents/plugins/marketplace.json
- skills/novome-coach/SKILL.md
- skills/novome-coach/agents/openai.yaml
- evals/cases.yaml
- examples/demo-session.md
- AGENTS.md

Use the current official OpenAI Codex plugin and skill documentation as the source of truth.

Required work:
1. Validate all JSON and YAML syntax.
2. Validate manifest fields, path rules, marketplace source resolution, skill frontmatter, and explicit invocation policy.
3. Determine whether `codex plugin marketplace add avarba/Novome --ref main` can expose this repository as a marketplace and install the plugin from the repository root.
4. Identify only concrete blockers or incompatibilities. Do not redesign the product.
5. Make the smallest fixes needed for a reliable local installation.
6. Review the canonical behavior in examples/demo-session.md against skills/novome-coach/SKILL.md.
7. Review the behavioral cases in evals/cases.yaml and report any contradictions.
8. Update README only when the verified installation process differs from the current instructions.
9. Create a focused branch, commit the changes, push it, and open a draft pull request linked to issue #1.

Hard scope restrictions:
- Do not create a website.
- Do not add a backend, database, authentication, MCP server, lifecycle hooks, external profile integrations, analytics, or persistent learner memory.
- Keep version 0 instruction-only.
- Do not weaken the rule that Novome teaches one skill at a time and requires learner participation.

Definition of done:
- Repository structure matches current official Codex requirements.
- JSON and YAML are valid.
- Exact local installation and invocation steps are documented.
- Any assumptions that cannot be tested in this environment are explicitly listed.
- A draft PR contains only the minimal required changes.

Before ending, give me:
A. the installation steps I must perform in the ChatGPT desktop app or terminal;
B. the exact first `$novome-coach` test prompt;
C. the draft PR link;
D. anything I must do manually because Codex cannot access that UI.
```
