" ==========================================
" = Vim Basic settings                     =
" ==========================================
set nocompatible                " viとの互換性off
set number
set showmatch
set showmode
set nobackup
set updatecount=0
set backspace=2                 " make backspace work like most other apps
" Tab Settings
set expandtab                   " タブの代わりにスペースを利用
set tabstop=2                   " ファイル中のタブ文字をスペース何個分で表示するか
set shiftwidth=2                " 自動挿入されるタブ文字を何文字にするか
set softtabstop=2               " タブキーを押した際に何文字スペースを入力するか
" Search Settings
set ignorecase                  " 検索時に大文字小文字を区別しない
set smartcase                   " 検索時に大文字が入れられた場合、大文字小文字を区別して検索する
set hlsearch                    " hilight search results
hi Search ctermbg=29            " hilight search background color
" Text format settings
set textwidth=70 
set formatoptions+=m            " マルチバイト文字列でも指定文字数で改行する
set formatoptions+=B            " 行連結の際、マルチバイトの前後で空白を挿入する
"set formatoptions+=M            " 行連結の際、マルチバイトの前後で空白を挿入しない
set wildmode=list,full          " :eの時にzshのように補完候補を出す
if version >= 704
  set wildignorecase            " :eの時に大文字小文字関係なくする
endif 

" Basic key mapping 
map <F2> :set invpaste<CR>

" ==========================================
" = Tab settings                           =
" ==========================================
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    <c-a> [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]<c-c> :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
"map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]<c-n> :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
map <silent> [Tag]<c-p> :tabprevious<CR>
" tp 前のタブ

" ==========================================
" = Vim plugin settings                    =
" ==========================================
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" ==========================================
" = NeoBundle                              =
" ==========================================
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimproc'
NeoBundle 'The-NERD-tree'
"NeoBundle 'The-NERD-Commenter'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'taglist.vim'

" ==========================================
" = Settings for neocomplcache             = 
" ==========================================
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
imap <C-n> <C-x><C-o>

" ==========================================
" = Settings for Nerd Tree                 = 
" ==========================================
"map <C-b> :NERDTreeToggle<CR>

" ==========================================
" = Settings for vim-powerline             = 
" ==========================================
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set guifont=MigMix\ 1P,MigMix\ 1P\ for\ Powerline:style=Regular
let g:Powerline_symbols = 'fancy'
set t_Co=256

" ==========================================
" = Settings for syntastic                 = 
" ==========================================
let g:syntastic_mode_map = {'mode': 'passive'}
cnoreabbrev C SyntasticCheck

" ==========================================
" = Settings for taglist                   = 
" ==========================================
map <C-i> :TlistToggle<CR>

" ==========================================
" = Settings for ctags                     = 
" ==========================================
set tags=tags;/   "カレントディレクトリから上位に向かってctagsファイルを探して最初に見つけた物を読み込む
map <C-]> g<C-]>
map <C-c> :tag<CR>
"map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" ==========================================
" = Settings for perl                      = 
" ==========================================
autocmd FileType perl setlocal textwidth=0

syntax on
filetype plugin indent on

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
