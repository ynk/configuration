export ZSH_CONFIG=~/.config/zsh
export ZSH=$ZSH_CONFIG/oh-my-zsh
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


#aliases

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias reload='source $ZSH_CONFIG/zshrc'


bindkey "^[[Z" reverse-menu-complete  #shift tab
bindkey '^ ' magic-space               # space 


source $ZSH_CONFIG/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


export EDITOR=nano

HISTSIZE=5000
SAVEHIST=10000
HISTFILE=$ZSH_CONFIG/.zsh_history
setopt HIST_IGNORE_DUPS 
setopt HIST_IGNORE_ALL_DUPS 
setopt HIST_SAVE_NO_DUPS 


export PATH="$HOME/bin:$PATH"


#create syslink if not existed
if [ ! -L "$HOME/.zshrc" ]; then
  ln -sf "$ZSH_CONFIG/zshrc" "$HOME/.zshrc"
fi