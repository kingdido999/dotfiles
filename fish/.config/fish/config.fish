# Start in home directory if dropped into /
if status is-login; and test "$PWD" = /
    cd ~
end

# Environment variables
set -gx EDITOR hx
set -gx SHELL (which fish 2>/dev/null)

# PATH setup
if test (uname) = "Darwin"
    # Homebrew
    if test -d /opt/homebrew/bin
        set -gx PATH /opt/homebrew/bin $PATH
    end
else if test (uname) = "Linux"
    # Linuxbrew
    if test -x /home/linuxbrew/.linuxbrew/bin/brew
        set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
        set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
        set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
        set -gx PATH $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $PATH
    end
end
set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

# fzf integration
fzf --fish | source

# Aliases - Git
alias ga "git add ."
alias gc "git commit -m"
alias gd "git diff"
alias gs "git status"
alias gp "git push"
alias gpl "git pull"

# Aliases - Dotfiles
alias dot "cd ~/dotfiles && hx ."

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/pengchengding/.lmstudio/bin
# End of LM Studio CLI section

