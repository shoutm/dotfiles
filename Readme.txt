- Zsh(Prezto) settings
  1. Git clone prezto
      $ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  2. Initial settings
      $ setopt EXTENDED_GLOB
      $ for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done
  3. Override .zpreztorc
      $ cp ~/dotfiles/.zpreztorc ~/
  4. Make an external module directory
      $ mkdir ~/.zprezto-contrib
  5. Git clone external modules
      - zsh-peco-history
        $ git clone https://github.com/jimeh/zsh-peco-history.git ~/.zprezto-contrib/zsh-peco-history

- Vim settings
  1. clone kickstart.nvim
    $ git clone git@github.com:shoutm/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

- Install Nerd fonts
  - brew tap homebrew/cask-fonts
  - brew install font-roboto-mono-nerd-font


- Tmux settings
  1.Install tmux plugins
    $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    $ tmux
    $ ^z I
