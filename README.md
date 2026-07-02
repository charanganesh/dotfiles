# dotfiles

Personal dotfiles — zsh, git, Ghostty, and Claude Code config.

## What's included

- `zshrc` — zsh config with oh-my-zsh, autosuggestions, syntax highlighting, and aliases
- `gitconfig` — git config; routes identity by remote (see below)
- `gitconfig-personal` — personal git email, auto-applied to `github.com/charanganesh/*` repos
- `ghostty_config` — Ghostty terminal config (theme, fonts)
- `claude/` — Claude Code config: settings, hooks, and ccnotify
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

Plugin state (`installed_plugins.json`, `known_marketplaces.json`) is **not** tracked — Claude Code rewrites it on every update with machine-specific paths. Reinstall plugins on a new machine via `/plugin` in Claude Code.

## Git identity (works on personal + work machines)

Identity is split across three files so the same repo is safe on both:

- `gitconfig` (→ `~/.gitconfig`) — shared config, no default email
- `gitconfig-personal` (→ `~/.gitconfig-personal`) — personal email, auto-applied to any repo whose remote is `github.com/charanganesh/*` via a `hasconfig` conditional include (routes by remote URL, not directory)
- `~/.gitconfig-local` — **not tracked**; the machine's default email. `install.sh` seeds a template; set it to your work email on a work Mac.

Net effect: personal repos always commit as personal; everything else uses the machine default. On a work Mac, set `~/.gitconfig-local` to your work email and personal repos still resolve correctly.

## Adding more dotfiles

1. Copy the file into `~/dotfiles/`
2. Add a `symlink` line in `install.sh`
3. Commit and push
