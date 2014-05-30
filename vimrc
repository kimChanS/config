set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
filetype plugin indent on

" 代码片段
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
" 放到.vim/additional_snippets文件夹下
let g:UltiSnipsSnippetDirectories=["additional_snippets", 'UltiSnips']

Bundle 'nvie/vim-flake8'
Bundle 'Yggdroot/indentLine'
Bundle 'Raimondi/delimitMate'
"Bundle 'cschlueter/vim-mustang'
"Bundle 'godlygeek/csapprox'
Bundle 'scrooloose/syntastic'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/rainbow_parentheses.vim'

" 自动补全html标签
Bundle 'docunext/closetag.vim'
let g:closetag_html_style=1

" 状态栏强化
Bundle 'bling/vim-airline'
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax enable
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" 显示行数
set nu
"set autoindent
"set smartindent
set ruler
set showcmd
set showmatch
set wrap
"set textwidth=80
set colorcolumn=80
"highlight ColorColumn ctermbg=110 guibg=#2c2d27
set list
set listchars=tab:▸▸,eol:¬,extends:»,precedes:«

set so=3

" 搜索时忽略大小写
set ignorecase
" 高亮搜索词
set hlsearch
" 突出当前行
set cursorline
" tab键
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

set laststatus=2

let Tlist_Use_LEFT_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer'
map <F4> :TlistToggle<cr>

nmap wm :WMToggle<cr>
map <F6> :WMToggle<cr>

"theme
syntax enable
"set background=dark
"colorscheme solarized
colorscheme molokai
set t_Co=256

hi! link SignColumn LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" 显示增强-主题
Bundle 'altercation/vim-colors-solarized'
"let g:solarized_termtrans=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"

Bundle 'tomasr/molokai'
let g:molokai_original = 1
"let g:rehash256 = 1

" syntastic
let g:syntastic_check_on_open=1
let g:synctastic_python_checkers=['pyflakes']
let g:syntastic_python_flake8_args="--ignore=E501,E126,E128,E401,E701,E265"

"parentheses
let g:rbpt_colorpairs = [
    \ ['brown', 'RoyalBlue3'],
    \ ['Darkblue', 'SeaGreen3'],
    \ ['darkgray', 'DarkOrchid3'],
    \ ['darkgreen', 'firebrick3'],
    \ ['darkcyan', 'RoyalBlue3'],
    \ ['darkred', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown', 'firebrick3'],
    \ ['gray', 'RoyalBlue3'],
    \ ['black', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue', 'firebrick3'],
    \ ['darkgreen', 'RoyalBlue3'],
    \ ['darkcyan', 'SeaGreen3'],
    \ ['darkred', 'DarkOrchid3'],
    \ ['red', 'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" 保存py文件时删除多余空格
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" 自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
func! AutoSetFileHead()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    if &filetype == 'python'
        call setline(1, "\# coding:utf8")
    endif

endfunc

" 代码补全
"Bundle 'Valloric/YouCompleteMe'
