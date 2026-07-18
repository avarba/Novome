# Novome

**Learn to work with Codex while doing real work.**

Novome is an adaptive learning plugin for Codex. Instead of sending every learner through the same course, it inspects one real task, identifies one missing collaboration skill, delivers a short lesson at the moment it is needed, and checks whether the learner applies it.

## Build Week prototype

Version `0.1.0` focuses on four observable Codex collaboration skills:

- **Goal** — is the desired outcome clear?
- **Context** — did the learner provide the relevant files, errors, examples, and background?
- **Constraints** — are boundaries and non-goals explicit?
- **Verification** — is there objective evidence that the task is complete?

Novome uses evidence from the current conversation only. It does not claim to know the learner's general professional level and does not persist a personal profile.

## Five-minute demo

1. Install and enable the Novome plugin.
2. Open any coding repository in Codex.
3. Invoke the skill explicitly:

   ```text
   $novome-coach

   Fix the login bug.
   ```

4. Novome diagnoses the task and selects exactly one missing skill.
5. Complete the requested learning step.
6. Let Codex execute the revised task.
7. Invoke `$novome-coach` again and ask for a reflection.

Expected learning cycle:

```text
real task -> diagnosis -> one micro-lesson -> learner revision -> Codex execution -> reflection
```

## Install for local testing

### From GitHub

```bash
codex plugin marketplace add avarba/Novome --ref main
codex plugin marketplace list
```

Restart the ChatGPT desktop app, open **Codex → Plugins**, select the **Novome** marketplace, and install **Novome**.

### From a local clone

```bash
git clone https://github.com/avarba/Novome.git
cd Novome
codex plugin marketplace add .
```

Restart the ChatGPT desktop app and install **Novome** from the local marketplace.

## Explicit invocation

Version 0 intentionally disables implicit invocation. In Codex, type `$` or run `/skills`, then select:

```text
novome-coach
```

## Repository structure

```text
.codex-plugin/plugin.json          Plugin manifest
.agents/plugins/marketplace.json   Marketplace catalog
skills/novome-coach/SKILL.md       Adaptive coaching workflow
skills/novome-coach/agents/openai.yaml
examples/demo-session.md           Judge-ready demonstration
evals/cases.yaml                   Behavioral evaluation cases
docs/PROJECT_CHARTER.md            Product scope and definition of done
AGENTS.md                           Instructions for Codex contributors
```

## Version 0 boundaries

Version 0 has no website, account system, database, external identity analysis, LinkedIn integration, GitHub profile analysis, MCP server, or lifecycle hooks. These are future extensions after the core learning loop has been validated.

## Privacy

Novome's instruction-only prototype works with the current Codex conversation. It does not introduce its own server or database and instructs Codex not to create persistent learner profiles.

## License

MIT
