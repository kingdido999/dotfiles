## Alias

alias cat="bat"

alias c="clear"

alias fe="nvim ~/.config/fish/config.fish"
alias fr="source ~/.config/fish/config.fish"

alias t="tmux"
alias ta="tmux attach-session -d -t $1"
alias tk="tmux kill-session -t $1"
alias tl="tmux ls"
alias tn="tmux new -s $1"

alias ga="git add $1"
alias gaa="git add -A"
alias gb="git branch"
alias gbl="git branch --list"
alias gbd="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"
alias gc="git checkout $1"
alias gcb="git checkout -b $1"
alias gca="git commit --amend"
alias gcm="git commit -m $1"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gpl="git pull"
alias grc="git rebase --continue"
alias grh="git reset --hard"
alias grim="git rebase -i master"
alias gs="git status"
alias gsl="git stash list"
alias gsp="git stash push -m $1"

set PATH /usr/local/bin $PATH
set PATH ~/.emacs.d/bin $PATH
set PATH ~/.cargo/bin $PATH

## FZF

### Solarized Light color scheme

set base03 234
set base02 235
set base01 240
set base00 241
set base0 244
set base1 245
set base2 254
set base3 230
set yellow 136
set orange 166
set red 160
set magenta 125
set violet 61
set blue 33
set cyan 37
set green 64

set -gx FZF_DEFAULT_OPTS "--height=50% --reverse
  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue,info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "

set -gx FZF_DEFAULT_COMMAND        'rg --files --no-ignore-vcs --hidden'
set -gx FZF_CTRL_T_COMMAND         $FZF_DEFAULT_COMMAND
