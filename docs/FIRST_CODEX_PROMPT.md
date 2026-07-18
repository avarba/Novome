# Core 1 execution status

The original instruction in this file asked the project owner to paste a validation prompt into Codex.

That repository work has now been executed directly through the connected GitHub workflow on branch:

```text
core-1-plugin-validation
```

The completed work includes:

- validating the current official Codex plugin and skill format;
- checking JSON and YAML structure;
- checking manifest and marketplace path rules;
- checking explicit-only skill invocation policy;
- identifying and fixing contradictions between the skill, demo, and evals;
- correcting the supported-surface and installation documentation;
- adding `docs/CORE_1_VALIDATION.md`.

No prompt needs to be copied into Codex for this repository review.

## Manual surface test still required

GitHub access cannot operate the ChatGPT desktop or Codex CLI plugin browser. The project owner must perform only the following UI/runtime verification:

```bash
codex plugin marketplace add avarba/Novome --ref core-1-plugin-validation
codex plugin marketplace list
```

Then install **Novome** through either:

- ChatGPT desktop app: **Codex → Plugins → Novome → Install**;
- Codex CLI: run `/plugins`, select the Novome marketplace, and install Novome.

Start a new session and test:

```text
$novome-coach

Fix the login bug.
```

The skill should diagnose one priority, teach one micro-lesson, request one learner addition, and stop before implementation.

After the final accepted version is merged into `main`, use `--ref main` instead of the validation branch.
