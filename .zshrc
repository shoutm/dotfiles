###############################
# Basic configuration         #
###############################
export EDITOR='nvim'
export GIT_EDITOR='vim'

###############################
# alias                       #
###############################
alias vi="nvim"
alias tmux="tmux -2"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias uuuu="cd ../../../.."
alias uuuuu="cd ../../../../.."
alias k="kubectl"

# Load Prezto
[[ -r ${ZDOTDIR:-$HOME}/.zprezto/init.zsh ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

###############################
# goenv settings              #
###############################
if [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  if [[ -d "$GOENV_ROOT/bin" ]]; then
    export PATH=${GOENV_ROOT}/bin:$PATH
  elif which goenv > /dev/null 2>&1; then
    GOENV_BIN_PATH=`dirname \`which goenv\``
    export PATH=${GOENV_BIN_PATH}:$PATH
  fi
  eval "$(goenv init -)"
fi
export GOPATH="$HOME/work/go"
# This should be after `eval "$(goenv init -)"` https://github.com/syndbg/goenv/blob/master/INSTALL.md
export PATH=$GOPATH/bin:$PATH

###############################
# kubectl settings            #
###############################
if which kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi

# Include local config
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
