" [Plugins] {{{
call plug#begin('~/.config/nvim/plugged')
    " Languages
    Plug 'nanotech/jellybeans.vim'      " colorscheme
    Plug 'scrooloose/nerdcommenter'     " shortcut/key map for comment
    Plug 'cakebaker/scss-syntax.vim'    " highlight for css and scss

    " Completion
    Plug 'sirver/ultisnips'             " manipulate code snippets(used vim-snippets engine)
    Plug 'honza/vim-snippets'           " snippets engine for ultisnips
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " complete engine
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'zchee/deoplete-clang'         " c/c++/object-c
    Plug 'shougo/neoinclude.vim'        " c family include header completion
    Plug 'zchee/deoplete-jedi'          " python source for deoplete
    Plug 'davidhalter/jedi-vim'       " python go to definition

    " Integration
    Plug 'christoomey/vim-tmux-navigator'	" Vim and tmux's buffer/window navigator

    " Interface
    Plug 'bling/vim-airline'                " beautify the status line
    Plug 'vim-airline/vim-airline-themes'   " themes for the status line
    Plug 'kshenoy/vim-signature'            " visualize the mark by the side of the line number
    Plug 'majutsushi/tagbar'                " visualize the tag of the current buffer content
    Plug 'wesq3/vim-windowswap'             " easily swap the buffer of two windows
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Commands
    Plug 'tpope/vim-unimpaired'             " Comman pair bracket command
    Plug 'tpope/vim-surround'               " Manipulate pair characters easily

    " Others
call plug#end()
" }}}

" [sirver/ultisnips] {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" [cakebaker/scss-syntax.vim] {{{
autocmd FileType scss set iskeyword+=-
" }}}

" [nerdcommenter] {{{
let g:NERDSpaceDelims = 1
" }}}

" [deoplete] {{{
let g:deoplete#sources#clang#libclang_path = "/usr/lib/llvm-7/lib/libclang.so.1"
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \ 'auto_complete_delay': 10,
    \ 'auto_refresh_delay': 10,
    \ 'smart_case': v:true,
    \ })

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " [deoplete-jedi] python autocomplete setting {{{
    let g:deoplete#sources#jedi#show_docstring=1
    " }}}

    " [deoplete-clang] python autocomplete setting {{{
    " let g:deoplete#sources#clang#libclang_path="/usr/lib/x86_64-linux-gnu/libclang-6.0.so.1"
    " let g:deoplete#sources#clang#clang_header="/usr/lib/clang/"
    " }}}

" }}}

" [nathanaelkane/vim-indent-guides] {{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size=1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
" }}}

" [vim-airline/vim-airline-themes] {{{
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
" }}}

" [majutsushi/tagbar] {{{
nnoremap <silent> <C-t> :TagbarToggle<CR>
" }}}

" [junegunn/fzf.vim] {{{
nnoremap <silent> <C-f> :FZF<CR>
" }}}

" [Custom] {{{
colorscheme jellybeans
let g:jellybeans_background_color_256='None'

" Open configure file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" shortcut to change to normal mode
inoremap jk <Esc>
inoremap <Esc> <nop>

let mapleader="\\"
filetype plugin indent on

syntax on
set encoding=utf8
set tabstop=4 shiftwidth=4 expandtab
set nocompatible
set cursorline
hi CursorLine cterm=underline ctermbg=none
set number
set relativenumber

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
"}}}

" [scss] {{{
autocmd FileType scss setlocal foldmethod=marker foldmarker={,}
autocmd FileType scss setlocal tabstop=2 shiftwidth=2 expandtab
" }}}

" [make] {{{
autocmd FileType make setlocal tabstop=4 shiftwidth=4 noexpandtab
" }}}

" [html] {{{
autocmd FileType html,htmldjango setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html,htmldjango setlocal foldmethod=syntax
autocmd FileType html,htmldjango setlocal nowrap
" }}}

" [scss] {{{
autocmd FileType css setlocal foldmethod=marker foldmarker={,}
autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
" }}}
