---
name: novome-installer
description: Install, update, reinstall, or verify the Novome Codex plugin on the local computer from the Novome repository. Use only when explicitly invoked for Novome setup. Do not use in cloud environments to claim a desktop installation.
---

# Novome Installer

Install or update Novome for the user without asking them to copy terminal commands.

## Rules

1. Determine whether the current Codex environment is local or cloud.
2. If the environment is cloud, explain that the cloud container cannot modify the user's desktop Codex profile. Do not claim success. Offer repo-scoped testing only.
3. On Windows in a local environment, inspect and run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-novome.ps1
```

Use `pwsh` instead of `powershell` when that is the available shell.

4. Ask for execution approval only when required by the current local security policy.
5. Do not ask the user to manually execute the individual `codex plugin` commands unless the script cannot run.
6. The installer must refresh or add the marketplace, reinstall Novome through the official CLI, and verify the result with JSON output.
7. Do not report installation success unless the verification command shows Novome as installed and enabled.
8. After success, tell the user to close the current Codex session and start a new local session before invoking `$novome-coach`.
9. Do not launch the coaching test in the same session, because newly installed skills are loaded in a new session.

## Completion report

Return:

```text
Novome installation
Environment: <local or cloud>
Marketplace: <added, upgraded, or unchanged>
Plugin: <installed and enabled, or failed>
Verification: <brief evidence>
Next action: Start a new Codex session and invoke $novome-coach.
```
