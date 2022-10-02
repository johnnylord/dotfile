" [Plugins] {{{
call plug#begin('~/.config/nvim/plugged')
    " Languages
    Plug 'nanotech/jellybeans.vim'		" colorscheme
    Plug 'scrooloose/nerdcommenter'		" shortcut/key map for comment

    " Completion
    Plug 'farmergreg/vim-lastplace'

    " Integration
    Plug 'christoomey/vim-tmux-navigator'	" Vim and tmux's buffer/window navigator

    " Interface
    Plug 'kshenoy/vim-signature'		" visualize the mark
    Plug 'majutsushi/tagbar'			" visualize the tag
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'wookayin/fzf-ripgrep.vim'

    " Commands
    Plug 'tpope/vim-unimpaired'			" Comman pair bracket command
    Plug 'tpope/vim-surround'			" Manipulate pair characters easily

    " Others
    Plug 'vim-scripts/DrawIt'			" Text-based diagram
call plug#end()
" }}}

" [nerdcommenter] {{{
let g:NERDSpaceDelims = 1
" }}}

" [majutsushi/tagbar] {{{
nnoremap <silent> <C-t> :TagbarToggle<CR>
" }}}

" [junegunn/fzf.vim] {{{
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <C-f> :RgFzf 
" }}}

let g:indentLine_enabled = 1

" [Custom] {{{
colorscheme jellybeans
nnoremap <silent> <leader>tb :set background=dark<cr>
nnoremap <silent> <leader>tl :set background=light<cr>

" Open configure file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <leader>rs :%s/\s\+$//e<cr>

" shortcut to change to normal mode
inoremap jk <Esc>

let mapleader="\\"

filetype plugin indent on
syntax on
set encoding=utf8
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab

set nocompatible
set number
set cursorline
set relativenumber
hi CursorLine cterm=underline ctermbg=none

set foldmethod=marker
set foldnestmax=10
set foldlevelstart=99
nnoremap <silent> <s-tab> za

nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $

" highlight group
highlight ExtraWhitespace ctermbg=darkred
highlight ColorColumn ctermbg=darkred

" Show trailing whitespace
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Match characters over the length limit
set colorcolumn=0
"}}}

" ====================== Different filetype setting ========================

" [c] {{{
autocmd FileType c,cpp setlocal foldmethod=marker foldmarker={,}
" }}}

" [python] {{{
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python let g:NERDSpaceDelims=0
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
"}}}

" [yaml] {{{
autocmd FileType yaml setlocal foldmethod=indent
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" }}}

" [yaml] {{{
autocmd FileType ruby setlocal foldmethod=indent
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" }}}

" [make] {{{
autocmd FileType make setlocal tabstop=4 shiftwidth=4 noexpandtab
" }}}
