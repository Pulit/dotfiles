set encoding=utf-8
set fenc=utf-8
scriptencoding utf-8

" 文字コード
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

" tab indent
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2" "画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅

set t_Co=256
syntax enable

" backspace を有効にする
set backspace=indent,eol,start


" 文字列検索
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


" カーソル
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト
" set cursorcolumn
set virtualedit=onemore
set smartindent


" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk


set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" タブ関係の設定
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
    let no = i  " display 0-origin tabpagenr
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
" set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap  [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>



if has('vim_starting')
  " 初回起動時のみruntimepathにNeobundleのパスを指定する
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " NeoBundleが未インストールであればgit cloneする
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install NeoBundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
endif

call neobundle#begin(expand('~/.vim/bundle'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理

NeoBundleFetch 'Shugo/neobundle.vim'


  " 下部にかっこいいlightlineを表示
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'itchyny/vim-gitbranch'
  NeoBundle 'tpope/vim-fugitive'
  set laststatus=2
  set showmode
  set showcmd
  set ruler

  let g:lightline = {
    \ 'colorscheme' : 'wombat',
    \ 'active':{
    \   'left' : [[ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
    \ },
    \ 'component_function' : {
    \   'gitbranch' : 'fugitive#head'
    \},
    \ }


  " 空白行を赤く表示
  NeoBundle 'bronson/vim-trailing-whitespace'

  " インデントの可視化
  " NeoBundle 'Yggdroot/indentLine'

  " Pasteする時のインデントが狂わないようにする
  NeoBundle 'ConradIrwin/vim-bracketed-paste'


  if has('lua')
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete'
    " NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
  endif

  if neobundle#tap('neocomplete')
    call neobundle#config({
      \ 'depends' : ['Shougo/context_filetype.vim', 'ujihisa/neco-look','pocke/neco-gh-issues', 'Shougo/neco-syntax'],
      \ })

    " 起動時に有効化
    let g:neocomplete#enable_at_startup = 1

    " 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1

    " _ (アンダースコア)区切りの補完を有効化
    let g:neocomplete#enable_underbar_completion = 1
    let g:neocomplete#enable_camel_case_completetion = 1

    " ポップアップメニューで表示される候補の数
    let g:neocomolete#max_list = 20

    " シンタックスをきゃっすする時の最小文字長
    let g:neocomplete#source#syntax#min_keyword_length = 3

    " 補完を表示する最小文字数
    let g:neocomplete#auto_completion_start_length = 3

    " preview window を閉じない
    let g:neocomplete#enable_auto_close_preview = 0
    " AutoCmd InsertLeave * silent! pclose!

    let g:neocomplete#max_keyword_width = 1000

    if !exists('g:neocomplete#delimiter_patterns')
      let g:neocomplete#delimiter_patterns = {}
    endif
    let g:neocomplete#delimiter_patterns.ruby = ['::']

    if !exists('g:neocomplete#same_filetypes')
      let g:neocomplete#same_filetypes = {}
    endif

    let g:neocomplete#same_filetypes.ruby = 'eruby'

    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.typescript = '[^. \t]\.\%(\h\w*\)\?' " Same as JavaScript
    let g:neocomplete#force_omni_input_patterns.go = '[^. \t]\.\%(\h\w*\)\?'         " Same as JavaScripti

    let s:neco_dicts_dir = $HOME . '/dicts'
    if isdirectory(s:neco_dicts_dir)
      let g:neocomplete#source#dictionary#dictionaries = {
            \ 'ruby' : s:neco_dicts_dir . '/ruby.dict',
            \ 'javascript' : s:neco_dicts_dir . '/jqueri.dict',
            \}
    endif

    let g:neocomplete#data_directory = $HOME . '/.vim/cache/neocomplete'

    " call neocomplete#custom#source('look', 'min_pattern_length', 1)

    call neobundle#untap()
  endif

  " 多機能セレクタ
  NeoBundle 'ctrlpvim/ctrlp.vim'

  " CtrlPの拡張プラグイン. 関数検索
  NeoBundle 'tacahiroy/ctrlp-funky'

  " CtrlPの拡張プラグイン. コマンド履歴検索
  NeoBundle 'suy/vim-ctrlp-commandline'

  let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100'
  let g:ctrlp_show_hiddne = 1
  let g:ctrlp_types = ['fil']
  let g:ctrlp_extensions = ['funcky', 'commandline']

  command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

  let g:ctrlp_funcky_matchtype = 'path'

  " 括弧やクォートを補完してくれる
  NeoBundle 'cohama/lexima.vim'
  " NeoBundle 'Townk/vim-autoclose'

  " ログファイルなどに色付け
  NeoBundle 'vim-scripts/AnsiEsc.vim'

  " Golang関係
  NeoBundle 'fatih/vim-go'
  NeoBundle 'vim-jp/vim-go-extra'
  NeoBundle 'scrooloose/syntastic'
  NeoBundleLazy 'fatih/vim-go' ,{ 'autoload' : { 'filetype' : 'go' } }

  let g:syntastic_mode_map = { 'mode' : 'passive', 'active_files' : ['go']}
  let g:syntastic_go_checkers = ['go', 'golint']

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interface = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1

  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/

  let g:go_fmt_command = "goimports"


  " Javascript 関係
  NeoBundleLazy 'othree/yajs.vim',{'autoload':{'filetypes':['javascript']}}
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript


  " スクロールが滑らかになる
  NeoBundle 'yonchu/accelerated-smooth-scroll'

  " colorscheme
  syntax on
  colorscheme hopscotch

  call neobundle#end()

  filetype plugin indent on
  NeoBundleCheck
