export ZSH_CONFIG="$HOME/.config/zsh"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
ZSH_CUSTOM="$ZSH_CONFIG"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  sudo
  zsh-you-should-use
  fast-syntax-highlighting
  fzf-tab
  history-substring-search
)

source $ZSH/oh-my-zsh.sh

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias reload='source $ZSH_CONFIG/.zshrc'

# keybindings
bindkey "^[[Z" reverse-menu-complete  # Shift Tab
bindkey '^ ' magic-space               # Space
export EDITOR=nano

HISTSIZE=5000
SAVEHIST=10000
HISTFILE="$ZSH_CONFIG/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

setopt AUTO_CD
setopt PUSHD_IGNORE_DUPS
setopt HIST_VERIFY        
setopt SHARE_HISTORY 
export PATH="$HOME/bin:$PATH"
mkdir -p "$ZSH_CONFIG"
if [ ! -L "$HOME/.zshrc" ]; then
  ln -sf "$ZSH_CONFIG/.zshrc" "$HOME/.zshrc"
fi
