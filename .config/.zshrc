export ZSH_CONFIG="$HOME/.config/zsh"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
ZSH_CUSTOM="$ZSH_CONFIG/custom"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  sudo
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias reload='source $ZSH_CONFIG/zshrc'

# Keybindings
bindkey "^[[Z" reverse-menu-complete
bindkey '^ ' magic-space

source $ZSH_CONFIG/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


export EDITOR=nano


HISTSIZE=5000
SAVEHIST=10000
HISTFILE="$ZSH_CONFIG/.zsh_history"
setopt HIST_IGNORE_DUPS 
setopt HIST_IGNORE_ALL_DUPS 
setopt HIST_SAVE_NO_DUPS 

# Add Custom Path
export PATH="$HOME/bin:$PATH"

# Ensure Symlink Exists
if [ ! -L "$HOME/.zshrc" ]; then
  ln -sf "$ZSH_CONFIG/zshrc" "$HOME/.zshrc"
fi
