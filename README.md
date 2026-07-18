# Novome

**Learn to work with Codex while doing real work.**

Novome is an adaptive learning plugin for Codex. Instead of sending every learner through the same course, it inspects one real task, identifies one missing collaboration skill, delivers a short lesson at the moment it is needed, and checks whether the learner applies it.

## Build Week prototype

Version `0.1.0` focuses on four observable Codex collaboration skills:

- **Goal** — is the desired outcome clear?
- **Context** — did the learner provide the relevant files, errors, examples, and background?
- **Constraints** — are boundaries and non-goals explicit?
- **Verification** — is there objective evidence that the task is complete?

Novome uses evidence from the current conversation and repository only. It does not claim to know the learner's general professional level and does not persist a personal profile.

## Supported surfaces

Local marketplace plugins can be installed and tested in:

- **Codex in the ChatGPT desktop app**;
- **Codex CLI** through `/plugins`.

Plugins are not available in Chat mode, the Codex IDE extension, or mobile. After installation, start a new Codex chat or CLI session so the bundled skill is loaded.

Official references:

- [Build Codex plugins](https://developers.openai.com/codex/plugins/build)
- [Use Codex plugins](https://developers.openai.com/codex/plugins)
- [Build Codex skills](https://developers.openai.com/codex/skills)

## Install by asking Codex

The preferred Windows workflow is to let a **local Codex session** perform the installation. Open this repository in Codex and ask:

```text
Install or update Novome on this computer, run scripts/install-novome.ps1, verify the result, and do not ask me to copy terminal commands.
```

Codex will run the repository installer, refresh the marketplace, reinstall the plugin through the official CLI, and verify that it is installed and enabled. A normal approval prompt may appear before local profile changes are made.

This must run in a local environment. A Codex cloud container cannot modify the Codex profile or plugin cache on the user's desktop computer.

See [Install Novome by asking Codex](docs/INSTALL_WITH_CODEX.md).

## Manual install from GitHub

Run in a terminal that has the Codex CLI:

```bash
codex plugin marketplace add avarba/Novome --ref main
codex plugin add novome --marketplace novome
codex plugin list --marketplace novome --json
```

Then restart Codex and start a new session.

### ChatGPT desktop app

1. Restart the ChatGPT desktop app.
2. Select **Codex**.
3. Start a new Codex chat.

### Codex CLI

```bash
codex
```

Start a new CLI session after installation.

## Refresh after a plugin change

When the GitHub branch or repository is updated, refresh and reinstall through Codex:

```bash
codex plugin marketplace upgrade novome
codex plugin remove novome --marketplace novome
codex plugin add novome --marketplace novome
```

Alternatively, ask a local Codex session to run `scripts/install-novome.ps1` again.

## Install from a local clone

```bash
git clone https://github.com/avarba/Novome.git
cd Novome
codex plugin marketplace add .
codex plugin add novome --marketplace novome
```

Restart Codex and start a new session.

## Five-minute judge test

In a new Codex session, invoke the skill explicitly:

```text
$novome-coach

Fix the login bug.
```

Expected behavior:

1. Before inspecting the workspace, Novome diagnoses Goal, Context, Constraints, and Verification from the task text.
2. It chooses exactly one learning priority.
3. It gives a micro-lesson of at most 80 words.
4. It asks the learner for one concrete addition and stops before repository search or implementation.
5. After the learner responds, it produces a Codex-ready brief without inventing requirements.
6. Only then may it inspect the repository and continue the coding task.
7. After the coding task, it reflects only on visible evidence from the current session.

A valid learner response for the canonical test is:

```text
Done when: add a regression test proving that pressing Enter twice sends only one login request, and make the relevant test suite pass.
```

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
scripts/install-novome.ps1         Codex-managed Windows installer
docs/INSTALL_WITH_CODEX.md         Agent-managed installation guide
docs/CORE_1_VALIDATION.md          Format and behavior validation report
examples/demo-session.md           Judge-ready demonstration
evals/cases.yaml                   Behavioral evaluation cases
docs/PROJECT_CHARTER.md            Product scope and definition of done
AGENTS.md                           Instructions for Codex contributors
```

## Version 0 boundaries

Version 0 has no website, account system, database, external identity analysis, LinkedIn integration, GitHub profile analysis, MCP server, or lifecycle hooks. These are future extensions after the core learning loop has been validated.

## Privacy

Novome's instruction-only prototype works with the current Codex conversation. It introduces no external server or database and instructs Codex not to create persistent learner profiles. Platform-level data handling remains governed by the ChatGPT or Codex service being used.

## License

MIT
