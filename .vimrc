" VIM Customizations File
" Author: Brendan Corcoran

set nocompatible

" Editor stuff
syn on
set number
set ruler
set tabstop=4
set shiftwidth=4

" Text manipulation
set autoindent
set smartindent
set showmatch

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Disable Beeps
set vb t_vb=

" Allow cursor to roam
set virtualedit=

" Incremental Search (live search on /)
set incsearch

" Set Statusline Format
set laststatus=2
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l,%v/%L\ (%p%%)]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
