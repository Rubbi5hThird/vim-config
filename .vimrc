"modify based on https://github.com/kristijanhusak/vimfiles
set nocompatible                                                                "This must be first, because it changes other options as a side effect.
set background=dark                                                             "Set background to dark
" set background=light                                                             "Set background to dark
filetype off                                                                    "required
call plug#begin('~/.vim/bundle')
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

Plug 'ryanoasis/vim-webdevicons'
Plug 'bogado/file-line'
Plug 'junegunn/vim-easy-align'
Plug 'ryanoasis/vim-webdevicons'
Plug 'tpope/vim-commentary'
Plug 'nelstrom/vim-visual-star-search'
" Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'duff/vim-bufonly'
Plug 'tmhedberg/matchit'
Plug 'gregsexton/MatchTag'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'honza/vim-snippets'
Plug 'elzr/vim-json'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'vivien/vim-linux-coding-style'

call plug#end()

filetype plugin indent on                                                       "Enable plugins and indents by filetype

let g:mapleader = ","                                                           "Change leader to a comma

let g:enable_bold_font = 1                                                      "Enable bold font in colorscheme

" ================ GUI options ====================

set guioptions-=m                                                               "remove menu bar
set guioptions-=T                                                               "remove toolbar
set guioptions-=L                                                               "remove left scrollbar when vertical split
set guioptions-=r                                                               "remove left scrollbar when vertical split
set guioptions-=l                                                               "remove left scrollbar
set guifont=Inconsolata\ for\ Powerline\ 12                                     "font setup
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
"set linespace=10                                                                "Set lineheight in gvim

" ================ General Config ====================

set t_Co=256                                                                    "Set 256 colors
set title                                                                       "change the terminal's title
set number                                                                      "Line numbers are good
set backspace=indent,eol,start                                                  "Allow backspace in insert mode
set history=500                                                                 "Store lots of :cmdline history
set showcmd                                                                     "Show incomplete cmds down the bottom
set noshowmode                                                                  "Hide showmode because of the powerline plugin
set gdefault                                                                    "Set global flag for search and replace
set gcr=a:blinkon500-blinkwait500-blinkoff500                                   "Set cursor blinking rate
set cursorline                                                                  "Highlight current line
set autoread                                                                    "Reload files changed outside vim
set smartcase                                                                   "Smart case search if there is uppercase
" set ignorecase                                                                  "case insensitive search
set hlsearch                                                                    "Highlight search term
set incsearch                                                                   "Jump to found term while searching
set showmatch                                                                   "Highlight matching bracket
" set mouse=a                                                                     "Enable mouse
set nostartofline                                                               "Jump to first non-blank character
set timeoutlen=1000 ttimeoutlen=200                                             "Reduce Command timeout for faster escape and O
set laststatus=2                                                                "Show statusbar
set fileencoding=utf-8 encoding=utf-8                                           "Set utf-8 encoding on write
set wrap                                                                        "Enable word wrap
set linebreak                                                                   "Wrap lines at convenient points
set listchars=tab:\ \ ,trail:·                                                  "Set trails for tabs and spaces
set list                                                                        "Enable listchars
set lazyredraw                                                                  "Do not redraw on registers and macros
set completeopt-=preview                                                        "Disable preview for autocomplete
set hidden                                                                      "Hide buffers in background
set conceallevel=2 concealcursor=i                                              "neosnippets conceal marker
set splitright                                                                  "Set up new splits positions
set tags=./tags;/                                                               "Find tags file

syntax on                                                                       "turn on syntax highlighting

" colorscheme solarized
colorscheme onehalfdark

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
" set expandtab
set smartindent
set autoindent
set nofoldenable

" ================ Auto commands ======================

augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufWritePre * :call s:StripTrailingWhitespaces()                  "Auto-remove trailing spaces
autocmd vimrc FileType html,javascript setlocal sw=2 sts=2 ts=2                 "Set 2 indent for html
autocmd vimrc FileType php,javascript setlocal cc=80                            "Set right margin only for php and js

autocmd vimrc GUIEnter * set vb t_vb=                                           "Disable visual bell completely
autocmd vimrc VimEnter * set vb t_vb=

autocmd vimrc BufNewFile,BufReadPost *.md set filetype=markdown                 "Set *.md extension to markdown filetype
autocmd vimrc FileType nerdtree syntax match hideBracketsInNerdTree
            \ "\]" contained conceal containedin=ALL

autocmd vimrc VimEnter,BufNewFile,BufReadPost * call s:LoadLocalVimrc()         "Load per project vimrc (Used for custom test mappings, etc.)

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                                                                    "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~                                                     "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8                                                                 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=5

" ================ Abbreviations ====================

cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap
cnoreabbrev bda BufOnly
cnoreabbrev t tabe
cnoreabbrev T tabe

" ================ Functions ========================

function! s:StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfunction

function! s:LoadLocalVimrc()
    if filereadable(glob(getcwd() . '/.vimrc.local'))
        :execute 'source '.fnameescape(glob(getcwd(). '/.vimrc.local'))
    endif
endfunction

function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" ================ Custom mappings ========================

" Comment map
nmap <Leader>c gcc
map q <c-v>

" Line comment command
xmap <Leader>c gc

" Map save to Ctrl + S
map <c-s> :w<CR>
imap <c-s> <C-o>:w<CR>
" Also save with ,w
nnoremap <Leader>w :w<CR>

" Easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Open vertical split
nnoremap <Leader>v <C-w>v

" Down is really the next line
nnoremap j gj
nnoremap k gk

" Map for Escape key
inoremap jj <Esc>

" Yank to the end of the line
noremap Y y$

" Move to the end of yanked text after yank and paste
nnoremap p p`]
vnoremap y y`]+
vnoremap p p`]

" Move selected lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clear search highlight
nnoremap <Leader><space> :noh<CR>

" Handle syntastic error window
nnoremap <Leader>es :Errors<CR>
nnoremap <Leader>ec :lclose<CR>

nnoremap <Leader>hf :NERDTreeFind<CR>
" Open NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Toggle between last 2 buffers
nnoremap <leader><tab> <c-^>

" Auto change directory to match current file
nnoremap <Leader>dc :cd %:p:h<CR>:pwd<CR>

" Filesearch plugin map for searching in whole folder

" Toggle buffer list
" nnoremap <Leader>b :CtrlPBuffer<CR>
" nnoremap <Leader>t :CtrlPBufTag<CR>
" nnoremap <Leader>f :CtrlP<CR>
" nnoremap <Leader>T :TagbarToggle<CR>
" nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <silent> <Leader>o :Files<CR>
nnoremap <silent> <Leader>s :Lines<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader>: :History:<CR>
nnoremap <silent> <Leader>/ :History/<CR>

" add doc header
" nnoremap <Leader>d :Dox<CR>
" nnoremap <Leader>h :DoxAuthor<CR>

"toggle linenumber
nnoremap <Leader>l :set nu!<CR>

" Maps for indentation in normal mode
nnoremap <tab> >>
nnoremap <s-tab> <<

" Indenting in visual mode
xnoremap <s-tab> <gv
xnoremap <tab> >gv

" Resize window with shift + and shift -
nnoremap + <c-w>5>
nnoremap _ <c-w>5<

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Center highlighted search
" nnoremap n nzz
" nnoremap N Nzz

nmap n nzz
nmap N Nzz

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

" ================ plugins setups ========================

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:25,results:25'           "Ctrlp window setup
let g:ctrlp_custom_ignore = {'dir':  '\v[\/]\.(meteor)$'}                       "Ignore .meteor folder
let g:ctrlp_prompt_mappings = {'PrtDeleteEnt()': ['<c-@>']}                     "Map delete buffer in ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }

let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_briefTag_post="- "
let g:DoxygenToolkit_paramTag_pre="@"
let g:DoxygenToolkit_paramTag_post=": "
let g:DoxygenToolkit_returnTag="Return "
" let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
" let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Rubbi5hThird"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_briefTag_structName="yes"
let g:DoxygenToolkit_licenseTag="My own license"

" Include local vimrc if exists
if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

au FileType gitcommit set tw=72

" plugin inuxsty.vim
let g:linuxsty_patterns = [ "/usr/src/", "/linux", "/android-kernel"]

" light line
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ }

let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --theme=Dracula --style=header,grid --line-range :300 {}'"
