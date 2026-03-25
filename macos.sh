#!/bin/bash

# macOS system preferences
# Run: ./macos.sh
# Some changes require logout/restart to take effect.

echo "Applying macOS settings..."

# --- Dock ---
defaults write com.apple.dock autohide -bool true           # auto-hide dock
defaults write com.apple.dock tilesize -int 67              # icon size
defaults write com.apple.dock show-recents -bool false      # hide recent apps
defaults write com.apple.dock minimize-to-application -bool true  # minimize into app icon

# --- Finder ---
defaults write com.apple.finder AppleShowAllFiles -bool true        # show hidden files
defaults write com.apple.finder ShowPathbar -bool true              # show path bar
defaults write com.apple.finder ShowStatusBar -bool true            # show status bar
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # list view by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true     # show all file extensions

# --- Keyboard ---
defaults write NSGlobalDomain KeyRepeat -int 1                              # fast key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15                      # short delay before repeat
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# --- Trackpad ---
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false  # natural scroll off

# --- Screenshots ---
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# Restart affected apps
killall Dock Finder 2>/dev/null

echo "Done. You may need to log out and back in for all changes to take effect."
