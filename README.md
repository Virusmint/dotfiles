## Preview

No screenshots?

## Installation

It might be preferable to pick and choose specific configuration files, scripts and designs from this repository, and tailor them to one's own configuration, but a complete installation of this setup is also possible - the steps detailed below follow the official Arch documentation's approach: [https://wiki.archlinux.org/title/Dotfiles](https://wiki.archlinux.org/title/Dotfiles).

First clone this repository as a _--bare_ repo, which allows us to avoid dealing with complicated symlinks and dotfile management tools. Instead, what we will get at the end is a clean integration where the config files live exactly where the system expects (`$HOME`), while Git manages their history from a hidden folder `$HOME/.dotfiles`.

```bash
git clone --bare git@github.com:Virusmint/dotfiles.git $HOME/.dotfiles
```

Create an alias that points the working tree of the repo to `$HOME`.

```bash
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```

Backup current configs to `.dotfiles-backup`.

```bash
mkdir -p .dotfiles-backup && \
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dotfiles-backup/{}
```

Finally, copy the new dotfiles into place.

```bash
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
