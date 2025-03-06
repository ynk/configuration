#!/bin/bash

set -e

ZSH_CONFIG="$HOME/.config/zsh"
ZSHRC_URL_BASE="https://raw.githubusercontent.com/ynk/configuration/refs/heads/main/.config/"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ -f /etc/debian_version ]; then
  OS="ubuntu"
elif [ -f /etc/arch-release ]; then
  OS="arch"
else
  exit 1
fi

if [ "$OS" == "ubuntu" ]; then
  sudo apt update && sudo apt install -y zsh git curl wget
elif [ "$OS" == "arch" ]; then
  sudo pacman -Syu --noconfirm zsh git curl wget
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
fi

mkdir -p "$ZSH_CONFIG"

# Ask user which version to install
read -p "Install (1) Full or (2) Minimal Zsh setup? [1/2]: " choice
if [ "$choice" == "2" ]; then
  ZSHRC_URL="$ZSHRC_URL_BASE/minimal.zshrc"
  PLUGINS=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "zsh-users/zsh-completions"
  )
  ln -sf "$ZSH_CONFIG/minimal.zshrc" "$HOME/.zshrc"
else
  ZSHRC_URL="$ZSHRC_URL_BASE/full.zshrc"
  PLUGINS=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "zsh-users/zsh-completions"
    "MichaelAquilina/zsh-you-should-use"
    "zdharma-continuum/fast-syntax-highlighting"
    "Aloxaf/fzf-tab"
    "zsh-users/zsh-history-substring-search"
  )
  ln -sf "$ZSH_CONFIG/full.zshrc" "$HOME/.zshrc"
fi

wget -O "$ZSH_CONFIG/.zshrc" "$ZSHRC_URL"
mkdir -p "$ZSH_CUSTOM/plugins"

for plugin in "${PLUGINS[@]}"; do
  plugin_name=$(basename "$plugin")
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
    git clone "https://github.com/$plugin.git" "$ZSH_CUSTOM/plugins/$plugin_name"
  fi
done

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

echo "Zsh setup complete! Run 'zsh' or restart your terminal."