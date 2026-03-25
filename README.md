# dotfiles

My personal terminal configuration. Includes zsh setup with oh-my-zsh, autosuggestions, and syntax highlighting.

## What's included

- `.zshrc` — zsh config with oh-my-zsh, plugins, and prompt settings
- `.gitconfig` — git user, editor, and tool config
- `install.sh` — sets up everything on a new machine automatically
- `macos.sh` — macOS system preferences (run once manually)

## Setup on a new machine

```bash
git clone https://github.com/charanganesh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

That's it. The script will:
1. Install oh-my-zsh if not already installed
2. Install `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
3. Symlink `~/.zshrc` and `~/.gitconfig` to this repo (backs up any existing files as `.bak`)

Optionally, apply macOS system preferences:
```bash
./macos.sh
```

## Adding more dotfiles

1. Copy the file into `~/dotfiles/` (e.g. `cp ~/.gitconfig ~/dotfiles/gitconfig`)
2. Add a `symlink` line in `install.sh` (e.g. `symlink gitconfig .gitconfig`)
3. Commit and push
