# dotfiles

My personal terminal configuration. Includes zsh setup with oh-my-zsh, autosuggestions, and syntax highlighting.

## What's included

- `.zshrc` — zsh config with oh-my-zsh, plugins, and prompt settings
- `install.sh` — sets up everything on a new machine automatically

## Setup on a new machine

```bash
git clone https://github.com/charanganesh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

That's it. The script will:
1. Install oh-my-zsh if not already installed
2. Install `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
3. Symlink `~/.zshrc` to this repo (backs up any existing file as `.zshrc.bak`)

## Adding more dotfiles

1. Copy the file into `~/dotfiles/` (e.g. `cp ~/.gitconfig ~/dotfiles/gitconfig`)
2. Add a `symlink` line in `install.sh` (e.g. `symlink gitconfig .gitconfig`)
3. Commit and push
