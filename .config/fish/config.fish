if not status is-interactive
    return 0
end

set fish_greeting

if test (uname -s) = Darwin
    fish_add_path /opt/homebrew/bin
else if test (uname -s) = Linux
    # pass for now
end

set -x EDITOR nvim
set -x VISUAL nvim

alias gg=lazygit
alias dot='gg --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dotf='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias gd=lazydocker
alias gp="DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker"
alias n=nvim
alias gitsane="git config pull.rebase true && git config rebase.autostash true"
alias l="eza --long --all --group --header --icons"
alias t="tree -C"
alias cat="bat"
alias icat="kitten icat"

starship init fish | source
