# Novome Build Week Project Charter

## Mission

Help people become better collaborators with Codex while they complete real work.

## Problem

People gain access to powerful AI coding tools before they learn how to define outcomes, provide relevant context, constrain solutions, and verify results. Static courses teach these ideas outside the moment in which they are needed and repeat material the learner may already understand.

## Prototype hypothesis

A learner will improve a concrete Codex collaboration skill when the system:

1. observes a real task;
2. identifies one immediately relevant gap;
3. teaches that skill in under one minute;
4. requires the learner to apply it;
5. verifies the changed behavior in the same session.

## Product

Novome version 0 is an installable Codex plugin containing one instruction-only skill, `novome-coach`.

It evaluates four dimensions:

- Goal
- Context
- Constraints
- Verification

It does not attempt to estimate the learner's complete professional competency.

## Primary user

A person who is beginning to use Codex or who uses it regularly but wants to improve the reliability and clarity of their collaboration with it.

## Canonical use case

A learner asks Codex to fix a real bug using an underspecified task. Novome identifies the absence of an objective definition of done, teaches verification briefly, asks the learner to add a testable acceptance criterion, and then lets Codex complete the revised task. At the end, Novome shows which behavior was independent and which followed a hint.

## Learning model

Each dimension can have only one of these session-scoped states:

- not observed
- needs help
- applied with a hint
- applied independently

The model is evidence-based and non-persistent in version 0.

## Differentiation

Novome is not:

- a conventional course;
- a prompt rewriting service;
- a generic chatbot tutor;
- an employee surveillance system;
- a permanent competency score.

Novome's learning unit is a change in behavior during a real task.

## Technical architecture: version 0

```text
Codex conversation
      ↓
explicit $novome-coach invocation
      ↓
instruction-only SKILL.md
      ↓
session evidence and learner action
      ↓
normal Codex repository work
      ↓
reflection in the same conversation
```

No backend, database, external API, MCP server, or hook is required for the first validated cycle.

## Definition of done

The prototype is complete when:

- the GitHub repository is public;
- the plugin manifest and marketplace catalog are valid;
- the plugin can be installed locally;
- `$novome-coach` can be explicitly invoked;
- a learner can complete diagnosis, micro-lesson, learner action, revised brief, implementation, and reflection;
- at least six behavioral cases have been reviewed;
- README includes a five-minute judge test;
- a public demo video under three minutes is available;
- the Build Week submission links the repository and video;
- a Codex session ID is captured if required by the event submission form.

## Non-goals for Build Week

- Full professional skill graph.
- LinkedIn, GitHub history, Discord, or email ingestion.
- Persistent learning memory.
- Organization dashboards.
- Marketplace monetization.
- General education across every subject.
- A complete website.

## Next validated extension

Only after the instruction-only cycle passes manual evals, evaluate one lifecycle hook that can observe task submission or completion without creating privacy or reliability problems.
