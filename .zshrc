###############################
# 基本設定                    #
###############################
export LANG=ja_JP.UTF-8

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
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
     color=%F{red}
  fi
  echo "$color($name)$action%f%b "
}

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
PROMPT="%{$fg[$time_color]%}[%D{%Y/%m/%d %T} %{$fg[$directory_color]%}%~%{$fg[$time_color]%}]
%{$fg[$prompt_color]%}%n@%B%{$fg[$hostname_color]%}%m%b %{$fg[$prompt_color]%}%# "
case ${UID} in
0)
  PROMPT="%{$fg[yellow]%}[%D{%Y/%m/%d %T} %~]
%n@%m %# "
  ;;
esac
#RPROMPT=' %D{%Y/%m/%d %T}'         # prompt for right side of screen
RPROMPT='`rprompt-git-current-branch`' # prompt for right side of screen

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
# その他                      #
###############################
setopt no_flow_control # C-s, C-qを無効にする
# RVMの設定
export PATH=$PATH:$HOME/.rvm/bin 
export GIT_EDITOR=vim
export SVN_EDITOR=vim
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# pythonz settings
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc
# virtualenv settings
[[ -s $HOME/.virtualenvs ]] && export WORKON_HOME=$HOME/.virtualenvs
which virtualenvwrapper.sh > /dev/null 
[[ $? == 0 ]] && source `which virtualenvwrapper.sh`
