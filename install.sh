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
