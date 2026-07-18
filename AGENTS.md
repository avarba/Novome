# AGENTS.md

## Project

Novome is an adaptive learning plugin for Codex. The Build Week prototype must demonstrate one complete learning loop during a real coding task.

## Current objective

Ship the smallest reliable version that can be installed, explicitly invoked, demonstrated in under three minutes, and understood by a judge in under five minutes.

## Product principles

1. Teach during real work, not before it.
2. Diagnose only observable evidence.
3. Teach one skill at a time.
4. Require learner participation.
5. Verify learning through changed behavior, not a generic quiz.
6. Keep learning state within the current session for version 0.
7. Prefer a complete narrow workflow over broad infrastructure.

## Version 0 scope

Included:

- Codex plugin manifest.
- One instruction-only skill: `novome-coach`.
- Explicit invocation.
- Goal, Context, Constraints, and Verification diagnosis.
- One micro-lesson.
- Learner revision.
- Codex-ready brief.
- End-of-task reflection.
- Demo and behavioral eval cases.

Excluded unless a tracked issue explicitly changes scope:

- Website or landing page.
- Authentication.
- Database or persistent learner model.
- LinkedIn, Discord, email, or GitHub profile ingestion.
- MCP servers.
- Lifecycle hooks.
- Billing.
- Course catalog or LMS features.
- Multi-agent orchestration.

## Change rules

- Inspect the existing repository before editing.
- Keep the plugin manifest compatible with current official Codex plugin documentation.
- Keep `SKILL.md` instruction-only until the manual learning loop passes evals.
- Do not add dependencies or infrastructure without documenting the exact demo requirement they unlock.
- Do not weaken the evidence and privacy rules in `skills/novome-coach/SKILL.md`.
- Keep micro-lessons at 80 words or fewer.
- Preserve explicit invocation until tests show implicit invocation is desirable and safe.

## Validation before completing a change

- Validate JSON and YAML syntax.
- Confirm all manifest paths start with `./` where required.
- Confirm the skill frontmatter contains `name` and `description`.
- Run or manually review every case in `evals/cases.yaml` affected by the change.
- Update README instructions when installation or invocation changes.
- Summarize what changed, what was verified, and what remains uncertain.

## Build Week demo contract

The canonical demo begins with an underspecified real coding task such as:

```text
Fix the duplicate login bug.
```

Novome must:

1. Identify one material missing dimension.
2. Give a concise task-specific lesson.
3. Ask the learner for one addition.
4. Mark that skill as applied with a hint after a valid response.
5. Produce a Codex-ready brief.
6. Allow Codex to complete and verify the underlying task.
7. Produce an evidence-based reflection.
