# Install Novome by asking Codex

The user does not need to operate PowerShell or the Plugins UI manually. A **local** Codex session can run the official Codex CLI installation commands on the user's machine.

## Why this must be local

Plugin installation updates the local Codex profile and cache under the user's home directory. A Codex cloud chat runs in a separate container, so it can install tools only inside that container; it cannot modify the ChatGPT desktop or Codex CLI installation on the user's Windows computer.

## Zero-install bootstrap

Codex automatically discovers repository skills under `.agents/skills`. The Novome repository includes an explicit bootstrap skill, so after opening this repository in local Codex the user can invoke:

```text
$novome-installer
```

No Novome plugin must already be installed for this bootstrap skill to appear. It belongs to the repository itself.

The equivalent natural-language request is:

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

## Cloud mode

The repository bootstrap skill is visible in Codex cloud because the repository is checked out there, but a cloud container cannot install the plugin into the user's desktop profile. In cloud mode, `$novome-installer` must report that limitation rather than claim success. Repository-scoped skills remain useful for cloud development and demonstrations; the plugin is the distribution format for availability across unrelated local repositories.
