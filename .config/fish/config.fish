if not status is-interactive
    return 0
end

set fish_greeting

if test (uname -s) = Darwin
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/local/bin /opt/local/sbin
    if test -f /Users/david/miniconda3/bin/conda
        eval /Users/david/miniconda3/bin/conda "shell.fish" hook $argv | source
    end
else if test (uname -s) = Linux
    # pass for now
end

set -x EDITOR nvim
set -x VISUAL nvim

alias gg=lazygit
alias gd=lazydocker
alias gp="DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker"
alias gitsane="git config pull.rebase true && git config rebase.autostash true"
alias dot='gg --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dotf='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias n='NVIM_APPNAME=nvim nvim'
alias ns='NVIM_APPNAME=nvim-scratch nvim'
alias l="eza --long --all --group --header --icons"
alias t="tree -C"
alias cat="bat"
alias icat="kitten icat"

starship init fish | source
