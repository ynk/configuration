#!/bin/bash

set -e

ZSH_CONFIG="$HOME/.config/zsh"
ZSHRC_URL="https://raw.githubusercontent.com/ynk/configuration/main/.config/.zshrc"
ZSH_CUSTOM="$HOME/.oh-my-zsh"

if [ -f /etc/debian_version ]; then
  OS="ubuntu"
elif [ -f /etc/arch-release ]; then
  OS="arch"
else
  exit 1
fi

if [ "$OS" == "ubuntu" ]; then
  sudo apt update && sudo apt install -y zsh git curl wget powerline fonts-powerline fonts-firacode fzf
elif [ "$OS" == "arch" ]; then
  sudo pacman -Syu --noconfirm zsh git curl wget powerline powerline-fonts ttf-fira-code fzf
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
fi

mkdir -p "$ZSH_CONFIG"
wget -O "$ZSH_CONFIG/.zshrc" "$ZSHRC_URL"
ln -sf "$ZSH_CONFIG/.zshrc" "$HOME/.zshrc"

mkdir -p "$ZSH_CUSTOM/plugins"
PLUGINS=(
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-completions"
  "MichaelAquilina/zsh-you-should-use"
  "zdharma-continuum/fast-syntax-highlighting"
  "Aloxaf/fzf-tab"
  "zsh-users/zsh-history-substring-search"
)

for plugin in "${PLUGINS[@]}"; do
  plugin_name=$(basename "$plugin")
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
    git clone "https://github.com/$plugin.git" "$ZSH_CUSTOM/plugins/$plugin_name"
  fi
done

mkdir -p "$HOME/.oh-my-zsh/themes"
curl -fsSL -o "$HOME/.oh-my-zsh/themes/agnoster.zsh-theme" "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/agnoster.zsh-theme"

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

echo "Zsh setup complete! run zsh"
