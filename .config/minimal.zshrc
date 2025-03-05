export ZSH_CONFIG="$HOME/.config/zsh"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
ZSH_CUSTOM="$ZSH_CONFIG"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias reload='source $ZSH_CONFIG/.zshrc'

export EDITOR=nano

HISTSIZE=2000
SAVEHIST=5000
HISTFILE="$ZSH_CONFIG/.zsh_history"

mkdir -p "$ZSH_CONFIG"
if [ ! -L "$HOME/.zshrc" ]; then
  ln -sf "$ZSH_CONFIG/minimal.zshrc" "$HOME/.zshrc"
fi
