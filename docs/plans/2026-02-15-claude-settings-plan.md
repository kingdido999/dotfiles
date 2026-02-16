# Claude Settings Stow Package — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Track Claude Code settings in the dotfiles repo with OS-conditional hooks via base + OS-specific JSON merge.

**Architecture:** A `claude/` stow package holds three JSON fragments: `settings.base.json` (shared config), `settings.darwin.json` (macOS hooks), and `settings.linux.json` (Linux hooks). At install time, `install.sh` deep-merges the base and OS-specific file with `jq` into `settings.json`, which Stow then symlinks to `~/.claude/settings.json`.

**Tech Stack:** GNU Stow, jq, Bash

---

### Task 1: Add jq to Brewfile

**Files:**
- Modify: `Brewfile`

**Step 1: Add jq**

Add this line to `Brewfile`:

```
brew "jq"
```

**Step 2: Commit**

```bash
git add Brewfile
git commit -m "Add jq to Brewfile for Claude settings merge"
```

---

### Task 2: Create settings.base.json

**Files:**
- Create: `claude/.claude/settings.base.json`

**Step 1: Create directory and file**

Create `claude/.claude/settings.base.json` with the shared config (everything except hooks):

```json
{
  "permissions": {
    "allow": [
      "Edit",
      "Write",
      "Bash(*)",
      "Grep",
      "Glob",
      "Read",
      "LS",
      "WebSearch",
      "WebFetch"
    ],
    "defaultMode": "default"
  },
  "enabledPlugins": {
    "swift-lsp@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true,
    "superpowers@claude-plugins-official": true,
    "hookify@claude-plugins-official": true,
    "serena@claude-plugins-official": true,
    "context7@claude-plugins-official": true,
    "obsidian@obsidian-skills": true
  },
  "effortLevel": "medium"
}
```

**Step 2: Commit**

```bash
git add claude/.claude/settings.base.json
git commit -m "Add Claude settings base config"
```

---

### Task 3: Create settings.darwin.json

**Files:**
- Create: `claude/.claude/settings.darwin.json`

**Step 1: Create the file**

Create `claude/.claude/settings.darwin.json` with macOS-specific hooks:

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": ".*",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Ping.aiff"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          }
        ]
      }
    ]
  }
}
```

**Step 2: Commit**

```bash
git add claude/.claude/settings.darwin.json
git commit -m "Add macOS-specific Claude hooks"
```

---

### Task 4: Create settings.linux.json

**Files:**
- Create: `claude/.claude/settings.linux.json`

**Step 1: Create the file**

Create `claude/.claude/settings.linux.json` as an empty object (no Linux hooks for now):

```json
{}
```

**Step 2: Commit**

```bash
git add claude/.claude/settings.linux.json
git commit -m "Add Linux-specific Claude settings (empty for now)"
```

---

### Task 5: Add .gitignore for generated settings.json

**Files:**
- Create: `.gitignore`

**Step 1: Create .gitignore**

```
claude/.claude/settings.json
```

**Step 2: Commit**

```bash
git add .gitignore
git commit -m "Gitignore generated Claude settings.json"
```

---

### Task 6: Update install.sh

**Files:**
- Modify: `install.sh`

**Step 1: Add jq merge step before stow**

Insert the following block before the `stow` line (line 19) in `install.sh`:

```bash
# Merge Claude settings for current OS
CLAUDE_OS="$(uname | tr '[:upper:]' '[:lower:]')"
jq -s '.[0] * .[1]' \
  "claude/.claude/settings.base.json" \
  "claude/.claude/settings.${CLAUDE_OS}.json" \
  > "claude/.claude/settings.json"
```

**Step 2: Add `claude` to the stow command**

Change line 19 from:

```bash
stow helix fish git tmux
```

to:

```bash
stow helix fish git tmux claude
```

**Step 3: Verify the merge works**

Run from repo root:

```bash
cd /Users/pengchengding/dotfiles
CLAUDE_OS="$(uname | tr '[:upper:]' '[:lower:]')"
jq -s '.[0] * .[1]' \
  "claude/.claude/settings.base.json" \
  "claude/.claude/settings.${CLAUDE_OS}.json"
```

Expected: Full merged JSON with both the base config and the macOS hooks.

**Step 4: Commit**

```bash
git add install.sh
git commit -m "Add Claude settings merge and stow to install.sh"
```

---

### Task 7: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

**Step 1: Add claude to the Stow Packages table**

Add this row to the table after the `tmux` row:

```
| `claude/` | `~/.claude/` | Claude Code settings (base + OS-specific hooks merged at install) |
```

**Step 2: Update the stow command examples**

Change:

```
stow helix fish git tmux  # Stow all packages
```

to:

```
stow helix fish git tmux claude  # Stow all packages
```

**Step 3: Commit**

```bash
git add CLAUDE.md
git commit -m "Document claude stow package in CLAUDE.md"
```

---

### Task 8: Test end-to-end

**Step 1: Run the merge and stow**

```bash
cd /Users/pengchengding/dotfiles
CLAUDE_OS="$(uname | tr '[:upper:]' '[:lower:]')"
jq -s '.[0] * .[1]' \
  "claude/.claude/settings.base.json" \
  "claude/.claude/settings.${CLAUDE_OS}.json" \
  > "claude/.claude/settings.json"
stow claude
```

**Step 2: Verify symlink**

```bash
ls -la ~/.claude/settings.json
```

Expected: symlink pointing to `/Users/pengchengding/dotfiles/claude/.claude/settings.json`

**Step 3: Verify content matches current settings**

```bash
diff <(jq -S . ~/.claude/settings.json) <(jq -S . /dev/stdin <<< '$(cat current)')
```

Or just visually confirm the merged file has all permissions, plugins, effort level, and hooks.
