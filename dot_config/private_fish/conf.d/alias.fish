alias c="clear"
alias cat="bat"
alias fr="source ~/.config/fish/config.fish"
alias v="nvim"
alias t="todo.sh"

if type -q exa
    alias ll "exa -l -g --icons"
    alias lla "ll -a"
end

# tmux
alias ta="tmux attach-session -d -t $1"
alias tk="tmux kill-session -t $1"
alias tl="tmux ls"
alias tn="tmux new -s $1"

# git
alias g="git"
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
alias grh="git reset --hard"
alias grim="git rebase -i master"
alias gs="git status"
