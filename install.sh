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

# Symlinks
symlink zshrc .zshrc
symlink gitconfig .gitconfig
mkdir -p "$HOME/.ssh" && symlink ssh_config .ssh/config

# Install oh-my-zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins if missing
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
echo "Done. Restart your terminal or run: source ~/.zshrc"
