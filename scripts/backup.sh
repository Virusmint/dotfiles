# Creates a backup of all configs in .dotfiles-backup/:w
mkdir -p .dotfiles-backup &&
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} |
    xargs -I{} mv {} .dotfiles-backup/{}
