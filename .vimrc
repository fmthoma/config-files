" move parentheses to end of parameter list
nnoremap ) xep
nnoremap ( xbP

" pgup and pgdown in hjkl
nnoremap <C-j> <PageDown>
nnoremap <C-k> <PageUp>

" tabs and line numbers
set expandtab
set tabstop=2
set shiftwidth=2
set number

execute pathogen#infect()
syntax on
filetype plugin indent on

" always display airline
set laststatus=2
