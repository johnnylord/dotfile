" [Plugins] {{{
call plug#begin('~/.config/nvim/plugged')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'kshenoy/vim-signature'
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/DrawIt'
    Plug 'wookayin/fzf-ripgrep.vim'
call plug#end()
" }}}

let mapleader="\\"

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :RgFzf<CR>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
inoremap jk <Esc>

syntax on
set encoding=utf8
set cursorline
set number
set noexpandtab
