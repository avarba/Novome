# Novome canonical demo session

## Demo objective

Show, in under three minutes, that Novome teaches one missing Codex collaboration skill during a real task and verifies that the learner applied it.

## Demo repository setup

Use a small application containing a reproducible duplicate-submit bug in a login or todo form. The repository should already have a test runner and one failing or missing regression case.

## Step 1 — learner invokes Novome

```text
$novome-coach

Fix the duplicate login bug.
```

## Expected Novome response

The exact wording may vary, but the behavior must match:

```text
Novome diagnosis
Goal: needs_help — "Fix" does not state the expected observable behavior.
Context: needs_help — No file, reproduction sequence, error, or repository inspection request is provided.
Constraints: not_observed — No implementation boundaries are stated.
Verification: needs_help — There is no objective definition of done.

Learning priority: Verification

Micro-lesson: Define done before delegating
A bug fix is safer when Codex knows what evidence proves it is complete. For this task, useful evidence is a reproduction case, a regression test, and the validation command that must pass.

Your step:
Add one `Done when` statement describing the regression evidence Codex must produce.
```

Novome must stop here. It must not implement the fix yet.

## Step 2 — learner applies the lesson

```text
Done when: add a regression test proving that pressing Enter twice sends only one login request, and make the relevant test suite pass.
```

## Expected Novome response

```text
Codex-ready brief

Goal
Prevent duplicate login submissions when the user presses Enter twice.

Context
The affected file and exact reproduction location are unknown. Inspect the repository to locate the login form, submission handler, authentication call, and existing test conventions before editing.

Constraints
No learner-supplied constraints. Apply only constraints confirmed in repository instructions or existing code contracts; otherwise keep this field marked as not observed.

Done when
A regression test proves that pressing Enter twice sends one login request, and the relevant test suite passes.
```

The brief must clearly distinguish learner-provided requirements, unknowns, and repository-derived evidence. Codex then inspects the repository, makes a focused fix, runs tests, and summarizes the result.

## Step 3 — reflection

After implementation, the learner says:

```text
$novome-coach Reflect on what I learned in this task.
```

## Expected reflection

```text
Novome reflection

Demonstrated independently
- You identified that the task concerned a login bug, but the initial observable outcome was incomplete.

Applied after a hint
- Verification: you added a precise regression condition requiring one request after a double Enter press and a passing test suite.

Still unverified
- Constraints were not independently supplied. Any constraints used during implementation must be tied to visible repository evidence.

Next practice
- On the next task, include the minimum relevant context: reproduction steps and the likely component or error output.
```

## Failure conditions

The demo fails if Novome:

- produces a complete rewritten prompt before the learner contributes;
- teaches more than one skill at once;
- gives a lecture longer than 80 words;
- calls the learner a beginner, expert, weak, or talented without evidence;
- claims to remember the learner across sessions;
- starts coding before asking for the learner step;
- reports a learned skill without visible evidence;
- invents constraints or business requirements;
- requests external account access.

## Three-minute video outline

- `0:00–0:20` — Problem: static training is separate from real AI work.
- `0:20–0:45` — Invoke Novome with the weak task.
- `0:45–1:10` — Show one diagnosis and micro-lesson.
- `1:10–1:30` — Learner adds the Done when criterion.
- `1:30–2:10` — Codex inspects, fixes, and runs the regression test.
- `2:10–2:35` — Show the evidence-based reflection.
- `2:35–2:55` — Show plugin structure and privacy boundary.
- `2:55–3:00` — Closing: "Novome turns every Codex task into a personalized learning moment."
