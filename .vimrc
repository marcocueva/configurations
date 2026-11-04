set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'tpope/vim-surround'
Plugin 'tmhedberg/SimpylFold'
Plugin 'kien/ctrlp.vim'
Plugin 'dracula/vim'
Plugin 'morhetz/gruvbox'

" Incremental search
Plugin 'haya14busa/incsearch.vim'

Plugin 'raimondi/delimitmate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rhysd/vim-healthcheck'
"
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set completeopt=menu,menuone,longest

set pumheight=15

" Enable 24-bit RGB colors in terminal
set termguicolors

" Set background to dark mode specifically for Gruvbox
set background=dark

" Apply colorscheme
colorscheme gruvbox

" Set contrast variant (optional: 'soft', 'medium', or 'hard')
let g:gruvbox_contrast_dark = 'medium'

"colorscheme dracula 

"No swap file
set noswapfile

" Command history
set history=500

"Show line number
set number
set relativenumber

" ===== Search options ======

"Highligth search matches
set hlsearch

"Ignore case when searching
set ignorecase
set smartcase

" Incremental searching (search as you type)

 set incsearch
 
 map /  <Plug>(incsearch-forward)
 map ?  <Plug>(incsearch-backward)
 map g/ <Plug>(incsearch-stay)

" Show incomplete commands
set showcmd

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Convert tabs to spaces
set expandtab
set tabstop=4

" The number of spaces inserted for a tab (used for auto indenting)
set shiftwidth=4

" Highlight tailing whitespace
set listchars=tab:\ \},trail:.

" Delete trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Always show status bar
set laststatus=2 " Always display the statusline in all windows

"set showtabline=2 " Always display the tabline, even if there is only one tab
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)

" Turn word wrap off
set nowrap
set sidescroll=5

" Switch syntax highlighting on, when the terminal has colors
syntax on

" Always show the cursor
set ruler

" Use the system clipboard
set clipboard=unnamedplus

" Don't show intro
set shortmess+=I

set splitbelow "split windows
set splitright

"split navigations
nmap <silent><A-Up> :wincmd k<CR>
nmap <silent><A-Down> :wincmd j<CR>
nmap <silent><A-Right> :wincmd l<CR>
nmap <silent><A-Left> :wincmd h<CR>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Enable folding
set foldmethod=indent
set foldlevel=99

" Close all folds when opening a new buffer
autocmd BufRead * setlocal foldmethod=marker
autocmd BufRead * normal zM

" Enable folding with the space bar
nnoremap <space> za

" Highlight the current line
set cursorline

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
set wildmenu

" redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" Always highlight column 80 so it's easier to see where cutoff appears on longer screens
autocmd BufWinEnter * highlight ColorColumn ctermbg=lightgray
set colorcolumn=80

set mouse=a

" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

" Change color scheme when diffing
fun! SetDiffColors()
  highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
  highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
  highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
  highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endfun
autocmd FilterWritePre * call SetDiffColors()

"use docx2txt.pl to allow VIm to view the text content of a .docx file directly.
augroup docx
    autocmd!
    autocmd BufReadCmd *.docx execute '%!docx2txt.pl' shellescape(expand('%'))
augroup END
