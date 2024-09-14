" Set compatibilty to vim
set nocompatible

" File type detection
filetype on
filetype plugin on
filetype indent on

" Turn on syntax highlighting
syntax on

" Set line numbers
set number
set relativenumber
set cursorline

" Set relative line numbers between normal mode and insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Format
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Set encoding 
set encoding=utf-8

" Highlight
set incsearch

" Search
set smartcase
nnoremap <esc> :noh<return><esc>

" Commands
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
