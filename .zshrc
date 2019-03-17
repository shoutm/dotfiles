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

###############################
# goenv settings              #
###############################
export GOPATH="$HOME/work/go"
if [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  if [[ -d "$HOME/.goenv/bin" ]]; then
    export PATH=${GOENV_ROOT}/bin:$PATH
  elif which goenv > /dev/null 2>&1; then
    GOENV_BIN_PATH=`dirname \`which goenv\``
    export PATH=${GOENV_BIN_PATH}:$PATH
  fi
  eval "$(goenv init -)"
fi

# # Auto activation of virtualenv when changing directory
# function chpwd() {
#   if [[ -d .venv ]]; then
#     source .venv/bin/activate
#   fi
# }


# Include local config
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local

# Load Prezto
[[ -r ${ZDOTDIR:-$HOME}/.zprezto/init.zsh ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
