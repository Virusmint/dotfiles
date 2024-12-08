# Set up the prompt
if not status is-interactive
    return 0
end

set -l os (uname)

# Aliases
alias gg=lazygit
#alias docker=podman
alias dot='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias gd=lazydocker
alias gp="DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker"
alias n=nvim
alias gitsane="git config pull.rebase true && git config rebase.autostash true"
alias l="eza --long --all --group --header --icons"
alias t="tree -C"
alias cat="bat"
alias icat="kitten icat"

# Default editor
set -x EDITOR nvim
set -x VISUAL nvim

# Disable fish greeting message
set -U fish_greeting

starship init fish | source
