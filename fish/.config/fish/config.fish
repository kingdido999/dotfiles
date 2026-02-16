# Environment variables
set -gx EDITOR hx
set -gx SHELL (which fish)

# PATH setup
if test (uname) = "Darwin"
    # Homebrew
    if test -d /opt/homebrew/bin
        set -gx PATH /opt/homebrew/bin $PATH
    end
else if test (uname) = "Linux"
    # Linuxbrew
    if test -x /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
end
set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

# Aliases - Git
alias ga "git add ."
alias gc "git commit -m"
alias gd "git diff"
alias gs "git status"
alias gp "git push"
alias gpl "git pull"

# Aliases - Dotfiles
alias dot "cd ~/dotfiles && hx ."
