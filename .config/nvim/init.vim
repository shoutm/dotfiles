" ==========================================
" = Vim Basic settings                     =
" ==========================================
set nocompatible                " viとの互換性off
set number
set showmatch
set showmode
set nobackup
set hidden
set updatecount=0
set backspace=2                 " make backspace work like most other apps
colorscheme default
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
set textwidth=0
set colorcolumn=80              " 80文字目にラインを入れる
set list                        " 不可視文字の可視化
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set formatoptions+=m            " マルチバイト文字列でも指定文字数で改行する
set formatoptions+=B            " 行連結の際、マルチバイトの前後で空白を挿入する
"set formatoptions+=M            " 行連結の際、マルチバイトの前後で空白を挿入しない
set wildmode=list,full          " :eの時にzshのように補完候補を出す
set infercase                   " 補完時に大文字小文字を区別しない
if version >= 704
  set wildignorecase            " :eの時に大文字小文字関係なくする
endif

" Basic key mapping
map <F2> :set invpaste<CR>

" Allow local config in each directories
set exrc
set secure

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

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nmap <silent> <c-w>'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> <c-w>c :tablast <bar> tabnew<CR>
map <silent> <c-w><c-c> :tablast <bar> tabnew<CR>

" tx タブを閉じる
"map <silent> <c-w>x :tabclose<CR>

" tn 次のタブ
map <silent> <c-w>n :tabnext<CR>
map <silent> <c-w><c-n> :tabnext<CR>

" tp 前のタブ
map <silent> <c-w>p :tabprevious<CR>
map <silent> <c-w><c-p> :tabprevious<CR>


" ==========================================
" = Window split settings                  =
" ==========================================
" Split horizontal / vertical
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Moving window
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Resizing window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

" ==========================================
" = Dein settings                          =
" ==========================================
" See https://qiita.com/delphinus/items/00ff2c0ba972c6e41542
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Load plugins from toml files
  let g:rc_dir    = expand('~/')
  let s:toml      = g:rc_dir . '.dein.toml'
  let s:lazy_toml = g:rc_dir . '.dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" ==========================================
" = Settings for deoplete                  =
" ==========================================
let g:deoplete#enable_at_startup = 1 " 起動時に有効化
imap <C-n> <C-x><C-o>                " Enable omni search by Ctrl-n

" ==========================================
" = Settings for VimFiler                  =
" ==========================================
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_edit_action = 'tabopen'
nnoremap sf :VimFilerExplorer<CR>

" ==========================================
" = Settings for taglist                   =
" ==========================================
map <C-i> :TlistToggle<CR>

" ==========================================
" = Settings for ctags                     =
" ==========================================
set tags=./tags;   "カレントディレクトリから上位に向かってctagsファイルを探して最初に見つけた物を読み込む
nnoremap <C-]><C-]> g<C-]>
nnoremap <C-c> :tag<CR>
nnoremap <C-]>v :vsp <CR><C-w>l g<C-]>
nnoremap <C-]>h :sp <CR><C-w>j g<C-]>
nnoremap <C-]>t :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

" ==========================================
" = Settings for fzf                       =
" ==========================================
if isdirectory('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
elseif isdirectory('~/.fzf')
  set rtp+=~/.fzf
endif
map ; :Files<CR>

" ==========================================
" = Settings for perl                      =
" ==========================================
autocmd FileType perl setlocal textwidth=0

syntax on
filetype plugin indent on

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
