# dotfiles

Personal dotfiles — zsh, git, Ghostty, and Claude Code config.

## What's included

- `zshrc` — zsh config with oh-my-zsh, autosuggestions, syntax highlighting, and aliases
- `gitconfig` — git user, editor, and tool config
- `ghostty_config` — Ghostty terminal config (theme, fonts)
- `claude/` — Claude Code config: settings, hooks, plugins, and ccnotify
- `agents/` — Custom Claude Code agent definitions
- `install.sh` — sets up everything on a new machine automatically
- `macos.sh` — macOS system preferences (run once manually)

## Setup on a new machine

```bash
git clone https://github.com/charanganesh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
1. Install oh-my-zsh if not already installed
2. Install `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
3. Symlink `~/.zshrc`, `~/.gitconfig`, and `~/.claude/settings.json` to this repo (backs up any existing files as `.bak`)

Optionally, apply macOS system preferences:
```bash
./macos.sh
```

## Claude Code

`claude/settings.json` contains hooks, enabled plugins, and the statusLine config for [claude-hud](https://github.com/jarrodwatts/claude-hud). The settings file is symlinked from `~/.claude/settings.json`.

`claude/ccnotify/ccnotify.py` is a hook script that sends macOS notifications when Claude finishes a task.

## Adding more dotfiles

1. Copy the file into `~/dotfiles/`
2. Add a `symlink` line in `install.sh`
3. Commit and push
