#!/bin/sh
# Claude Code status line - inspired by Hydro fish prompt style
# Displays: git-branch  context%  tokens↑↓  $cost

input=$(cat)

# Working directory (replace $HOME with ~, strip leading /)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home="$HOME"
display_pwd=$(echo "$cwd" | sed "s|^$home|~|")

# Git branch (skip optional locks to avoid blocking)
git_branch=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
    git_branch=$(git -C "$cwd" -c core.fsmonitor=false symbolic-ref --short HEAD 2>/dev/null \
        || git -C "$cwd" -c core.fsmonitor=false rev-parse --short HEAD 2>/dev/null)
fi

# Context remaining percentage
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Session cost
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# Token counts
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

# Build output with ANSI colors matching Hydro's dimmed palette
printf '\033[36m%s\033[0m' "$display_pwd"

if [ -n "$git_branch" ]; then
    printf ' \033[35m%s\033[0m' "$git_branch"
fi

if [ -n "$remaining" ]; then
    # Color context: green if plenty, yellow if low, red if critical
    remaining_int=$(printf '%.0f' "$remaining" 2>/dev/null || echo "$remaining" | cut -d. -f1)
    if [ "${remaining_int:-100}" -lt 10 ]; then
        printf ' \033[31mctx:%s%%\033[0m' "$remaining"
    elif [ "${remaining_int:-100}" -lt 25 ]; then
        printf ' \033[33mctx:%s%%\033[0m' "$remaining"
    else
        printf ' \033[32mctx:%s%%\033[0m' "$remaining"
    fi
fi

# Format token count (e.g., 1234 -> 1.2k, 1234567 -> 1.2M)
format_tokens() {
    local n="$1"
    if [ -z "$n" ] || [ "$n" = "null" ]; then return; fi
    if [ "$n" -ge 1000000 ]; then
        printf '%s.%sM' "$((n / 1000000))" "$(( (n % 1000000) / 100000 ))"
    elif [ "$n" -ge 1000 ]; then
        printf '%s.%sk' "$((n / 1000))" "$(( (n % 1000) / 100 ))"
    else
        printf '%s' "$n"
    fi
}

if [ -n "$input_tokens" ] && [ -n "$output_tokens" ]; then
    in_fmt=$(format_tokens "$input_tokens")
    out_fmt=$(format_tokens "$output_tokens")
    printf ' \033[33m%s\xe2\x86\x91 %s\xe2\x86\x93\033[0m' "$in_fmt" "$out_fmt"
fi

if [ -n "$cost" ] && [ "$cost" != "0" ]; then
    cost_fmt=$(printf '%.2f' "$cost")
    printf ' \033[33m$%s\033[0m' "$cost_fmt"
fi
