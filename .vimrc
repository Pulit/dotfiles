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
" set number " 行番号を表示
set cursorline " カーソルラインをハイライト
" set cursorcolumn
set virtualedit=onemore
set smartindent


" ステータスライン
" set laststatus=2



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


if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

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

  set laststatus=2
  set showmode
  set showcmd
  set ruler

  " 空白行を赤く表示
  NeoBundle 'bronson/vim-trailing-whitespace'

  " インデントの可視化
  " NeoBundle 'Yggdroot/indentLine'


  if has('lua')
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete'
    " NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
  endif

  if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にnetcompleteを有効にする
    let g:neocomplete#enable_at_startup = 1

    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1

    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#enable_auto_keyword_length = 3

    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1

    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"

    " タブキーで補完候補の選択. スニペット内ジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

    " Golang の自動補完設定
    let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
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

  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/





  " スクロールが滑らかになる
  NeoBundle 'yonchu/accelerated-smooth-scroll'
call neobundle#end()

filetype plugin indent on
NeoBundleCheck
