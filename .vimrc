" move parentheses to end of parameter list
nnoremap ) xep
nnoremap ( xbP

" pgup and pgdown in hjkl
nnoremap <C-j> <PageDown>
nnoremap <C-k> <PageUp>

nnoremap <C-p> :w<CR>:bprevious<CR>
nnoremap <C-n> :w<CR>:bnext<CR>

" tabs and line numbers
set expandtab
set tabstop=2
set shiftwidth=2
set number

execute pathogen#infect()
syntax on
filetype plugin indent on

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" longest: select longest common substring
" menuone: show menu even if there is only one option
set completeopt=longest,menuone
" Enter in completion menu selects current item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Select first item when opening completion menu
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
imap <C-@> <C-Space>

" always display airline
set laststatus=2
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" lenghtmatters config
call lengthmatters#highlight('ctermbg=0')

command Mdview %w !mdview

nnoremap <silent> <Esc> :nohlsearch<CR>

" Settings for base16
let base16colorspace=256
set background=dark
