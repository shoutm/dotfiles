###############################
# 基本設定                    #
###############################
#export LANG=ja_JP.UTF-8
export EDITOR='vim'

###############################
# 履歴設定                    #
###############################
HISTFILE=~/.histfile        # ヒストリファイルを指定
HISTSIZE=10000              # ヒストリに保存するコマンド数
SAVEHIST=10000              # ヒストリに保存するコマンド数
setopt auto_pushd           # cd - と入力してTabキーで今までに移動したディレクトリを一覧表示
setopt hist_no_store        # historyにhistoryコマンドを含めない
setopt hist_ignore_dups     # 重複する履歴は含まない

###############################
# 補完設定                    #
###############################
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # 大文字小文字を区別せずに補完
autoload -Uz compinit; compinit
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # 区切り文字としない文字を指定
setopt list_packed                  # 補完結果を詰めて表示
#setopt predict-on; predict-on      # 予測補完

###############################
# 色指定                      #
###############################
autoload colors; colors

###############################
# git setting                 #
###############################
autoload vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true

# hash changes branch misc

###############################
# PROMPT                      #
###############################
setopt prompt_subst #  PROMPT 変数の中の変数参照をプロンプト表示時に展開
# default prompt
time_color=cyan
directory_color=yellow
prompt_color=white
hostname_color=white
# 外部設定がある場合は読み込む
if [[ -r ~/.zshrc_prompt_color ]]; then
  . ~/.zshrc_prompt_color
fi
case ${UID} in
0)
  prompt_color=red
  ;;
esac

# git prompt setings
zstyle ':vcs_info:git*' formats "%{$fg[$prompt_color]%}[%{$fg[red]%}%u%{$fg[yellow]%}%c%{$fg[$prompt_color]%}] (%b)%m"
zstyle ':vcs_info:git*' actionformats "%c%u %b%m"
precmd (){ vcs_info } 

PROMPT="%{$fg[$time_color]%}[%D{%Y/%m/%d %T} %{$fg[$directory_color]%}%~%{$fg[$time_color]%}]
%{$fg[$prompt_color]%}%n%{$fg[white]%}@%B%{$fg[$hostname_color]%}%m%b %{$fg[$prompt_color]%}%# "
RPROMPT='${vcs_info_msg_0_}'

###############################
# keybind(emacsライク)        #
###############################
bindkey -e
#bindkey -v

###############################
# alias                       #
###############################
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ll="ls -la"
alias vi="vim"
alias tmux="tmux -2"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias uuuu="cd ../../../.."
alias uuuuu="cd ../../../../.."

###############################
# peco settings               #
###############################
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

###############################
# その他                      #
###############################
setopt no_flow_control # C-s, C-qを無効にする
export GIT_EDITOR=vim
export SVN_EDITOR=vim

###############################
# pyenv settings              #
###############################
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  if [[ -d "$HOME/.pyenv/bin" ]]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
  elif which pyenv > /dev/null 2>&1; then
    PYENV_BIN_PATH=`dirname \`which pyenv\``
    export PATH=${PYENV_BIN_PATH}:$PATH
  fi
  eval "$(pyenv init -)"
fi

###############################
# rbenv settings              #
###############################
if [[ -d "$HOME/.rbenv" ]]; then
  export RBENV_ROOT="$HOME/.rbenv"
  if [[ -d "$HOME/.rbenv/bin" ]]; then
    export PATH=${RBENV_ROOT}/bin:$PATH
  elif which rbenv > /dev/null 2>&1; then
    RBENV_BIN_PATH=`dirname \`which rbenv\``
    export PATH=${RBENV_BIN_PATH}:$PATH
  fi
  eval "$(rbenv init -)"
fi

###############################
# goenv settings              #
###############################
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

# Auto activation of virtualenv when changing directory
function chpwd() {
  if [[ -d .venv ]]; then
    source .venv/bin/activate
  fi
}

# ローカル設定の取り込み
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
