#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

symlink() {
  local src="$DOTFILES_DIR/$1"
  local dst="$HOME/$2"

  if [ -f "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up existing $dst → $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  ln -sf "$src" "$dst"
  echo "Linked $dst → $src"
}

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null
fi

# --- CLI tools ---
if ! command -v tmux &>/dev/null; then
  echo "Installing tmux..."
  brew install tmux
fi

if ! command -v dippy &>/dev/null; then
  echo "Installing dippy..."
  brew tap ldayton/dippy
  brew install dippy
fi

if ! command -v terminal-notifier &>/dev/null; then
  echo "Installing terminal-notifier..."
  brew install terminal-notifier
fi

if ! command -v recall &>/dev/null; then
  echo "Installing recall..."
  brew install zippoxer/tap/recall
fi

if ! command -v uv &>/dev/null; then
  echo "Installing uv..."
  brew install uv
fi

if ! command -v aichat &>/dev/null; then
  echo "Installing claude-code-tools..."
  uv tool install claude-code-tools
fi

# --- Ghostty ---
if [ ! -d "/Applications/Ghostty.app" ]; then
  echo "Installing Ghostty..."
  brew install --cask ghostty
fi

GHOSTTY_CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_CONFIG_DIR"
ln -sf "$DOTFILES_DIR/ghostty_config" "$GHOSTTY_CONFIG_DIR/config"
echo "Linked Ghostty config"

# --- Symlinks ---
symlink zshrc .zshrc
symlink gitconfig .gitconfig

# --- Claude Code ---
mkdir -p "$HOME/.claude/ccnotify"
mkdir -p "$HOME/.claude/plugins"
symlink claude/settings.json .claude/settings.json
symlink claude/ccnotify/ccnotify.py .claude/ccnotify/ccnotify.py
chmod +x "$HOME/.claude/ccnotify/ccnotify.py"
symlink claude/plugins/installed_plugins.json .claude/plugins/installed_plugins.json
symlink claude/plugins/known_marketplaces.json .claude/plugins/known_marketplaces.json

# --- Global agent skills ---
symlink agents .agents

# --- oh-my-zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- zsh plugins ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo ""
echo "Done. Open Ghostty and run: source ~/.zshrc"
