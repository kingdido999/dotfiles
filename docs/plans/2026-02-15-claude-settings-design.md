# Claude Settings Stow Package

## Goal

Track Claude Code settings in the dotfiles repo with OS-conditional hooks.

## File Structure

```
claude/
└── .claude/
    ├── settings.base.json      # Shared config (permissions, plugins, effort level)
    ├── settings.darwin.json    # macOS-only overrides (afplay hooks)
    └── settings.linux.json     # Linux-only overrides (paplay or empty)
```

`settings.json` is generated at install time and gitignored.

## Merge Strategy

`install.sh` deep-merges base + OS-specific files using jq:

```bash
OS="$(uname | tr '[:upper:]' '[:lower:]')"
jq -s '.[0] * .[1]' \
  "claude/.claude/settings.base.json" \
  "claude/.claude/settings.${OS}.json" \
  > "claude/.claude/settings.json"
```

jq's `*` operator does recursive object merge. OS-specific keys override base keys; everything else passes through.

## File Contents

**settings.base.json** contains everything except hooks:
- `permissions` (allow list, default mode)
- `enabledPlugins`
- `effortLevel`

**settings.darwin.json** contains macOS hooks:
- Notification hook: `afplay /System/Library/Sounds/Ping.aiff`
- Stop hook: `afplay /System/Library/Sounds/Glass.aiff`

**settings.linux.json** contains Linux hooks (or empty `{}` if no hooks desired).

## Changes to Existing Files

- **install.sh**: Add jq merge step before stow; add `claude` to stow command
- **Brewfile**: Add `jq` if not already present
- **.gitignore**: Add `claude/.claude/settings.json`

## CLAUDE.md Updates

Add `claude` package to the architecture table.
