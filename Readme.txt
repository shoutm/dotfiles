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
  1.Install Dein
    $ mkdir -p ~/.cache/dein
    $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    $ sh ./installer.sh ~/.cache/dein
  2.Install pynvim (see https://neovim.io/doc/user/provider.html)
    $ python2 -m pip install --user --upgrade pynvim
    $ python3 -m pip install --user --upgrade pynvim
  3.(When you update your plugins)
    :call dein#update()

  - vim-go settings
    - :GoInstallBinaries
      - See "Install" section in https://github.com/fatih/vim-go

- Tmux settings
  1.Install tmux plugins
    $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    $ tmux
    $ ^z I

(Ref) How to make ricty font for Vim (for Linux)
  - Required fonts
    - Inconsolata
      http://levien.com/type/myfonts/Inconsolata.otf
    - Migu 1M
      http://mix-mplus-ipa.sourceforge.jp/migu/

  - Required package
    - fontforge
      yum install fontforge

  - make ricty font
    $ git clone  https://github.com/yascentur/Ricty

    # After doing command above, move fonts to this directory.

    $ mv Ricty
    $ sh ricty_generator.sh auto

    then, 4 fonts are created. Move these fonts to .fonts directory.

    $ mv <4 fonts> ~/.fonts/

  - Patch ricty fonts.
    $ mv <4 fonts> ~/.vim/bundle/vim-powerline/fontpatcher/
    $ fontforge -lang=py -script fontpatcher Ricty-Regular.ttf
    $ fontforge -lang=py -script fontpatcher Ricty-Bold.ttf
    $ mv Ricty-Regular-Powerline.ttf ~/.fonts
    $ mv Ricty-Bold-Powerline.ttf ~/.fonts

(Ref) How to make ricty font for Vim (for Mac)
  - Follow the instructions listed in the page below
    http://morizyun.github.io/blog/ricty-font-homebrew-mac/
