- Vim settings
  1.How to make ricty font for Vim 
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

  2.Install NeoBundle
    $ mkdir -p ~/.vim/bundle
    $ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    
    then, start vim and do ":NeoBundleInstall"