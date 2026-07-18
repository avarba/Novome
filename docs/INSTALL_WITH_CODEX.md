# Install Novome by asking Codex

The user does not need to operate PowerShell or the Plugins UI manually. A **local** Codex session can run the official Codex CLI installation commands on the user's machine.

## Why this must be local

Plugin installation updates the local Codex profile and cache under the user's home directory. A Codex cloud chat runs in a separate container, so it can install tools only inside that container; it cannot modify the ChatGPT desktop or Codex CLI installation on the user's Windows computer.

## One natural-language request

Open this repository in a local Codex session and send:

```text
Install or update Novome on this computer, run scripts/install-novome.ps1, verify the result, and do not ask me to copy terminal commands.
```

Codex should:

1. inspect `AGENTS.md`;
2. run the PowerShell installer from the repository;
3. add or upgrade the `novome` marketplace;
4. remove an older installed copy when present;
5. install `novome` through `codex plugin add`;
6. verify the installed and enabled state with JSON output;
7. report the result.

The user may still receive a normal approval request before Codex executes commands that modify the local profile. That confirmation is a security boundary, not a manual installation workflow.

## What the installer runs

The script uses the official CLI surfaces:

```text
codex plugin marketplace list --json
codex plugin marketplace add avarba/Novome --ref core-1-plugin-validation --json
codex plugin marketplace upgrade novome --json
codex plugin remove novome --marketplace novome --json
codex plugin add novome --marketplace novome --json
codex plugin list --marketplace novome --json
```

The remove step is used only when an installed Novome copy is detected. The script is intended to be repeatable for installation and updates.

## After installation

The running Codex session does not reload newly installed skills in place. Close that session, start a new local Codex session, and invoke:

```text
$novome-coach

Fix the login bug.
```

## Zero-install option for cloud or repository development

Codex also discovers repository-scoped skills placed under `.agents/skills`. That mode requires no plugin installation, but the skill is available only while Codex is working inside a repository that contains it. It is useful for development and cloud demonstrations; the plugin remains the correct distribution format when Novome should be available across unrelated repositories.
