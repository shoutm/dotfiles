###############################
# 履歴設定                    #
###############################
HISTFILE=~/.histfile  # ヒストリファイルを指定
HISTSIZE=10000        # ヒストリに保存するコマンド数
SAVEHIST=10000        # ヒストリに保存するコマンド数
setopt auto_pushd     # cd - と入力してTabキーで今までに移動したディレクトリを一覧表示
setopt hist_no_store  # historyにhistoryコマンドを含めない

###############################
# 補完設定                    #
###############################
zstyle :compinstall filename '/home/monmon/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # 大文字小文字を区別せずに補完
autoload -Uz compinit; compinit
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # 区切り文字としない文字を指定
setopt list_packed                  # 補完結果を詰めて表示

###############################
# 色指定                      #
###############################
autoload colors; colors

###############################
# PROMPT                      #
###############################
PROMPT='[%n@%m]# '    # default prompt
RPROMPT=' %~'         # prompt for right side of screen

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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
