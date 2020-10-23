" plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -f -L -o ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if filereadable($MYVIMRC)
		let vimrc_path = $MYVIMRC
	elseif filereadable($VIM . '/vimrc')
		let vimrc_path = $VIM . '/vimrc'
	endif

	autocmd VimEnter * PlugInstall --sync | exec 'source ' . vimrc_path
endif

function! PlugLoaded(name)
    return (has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir))
endfunction

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'rizzatti/dash.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'plytophogy/vim-virtualenv'
Plug 'edkolev/tmuxline.vim'
Plug 'iamcco/markdown-preview.vim'
call plug#end()

filetype on
filetype plugin on
filetype indent on

runtime macros/matchit.vim

if PlugLoaded('nord-vim')
	colorscheme nord
endif
syntax on
" }}}

" options & variables {{{
set laststatus=2
set statusline=%y\ %.60F%=(%l/%L)
set backspace=2
set number
set autowrite
set nowrap
set noswapfile
set nocompatible
set path+=**
set wildmenu
set wildignore+=**/__pycache__/**,**/.git/**,*.pyc,**/venv/**
set updatetime=100

let maplocalleader = ","
let mapleader = " "

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1

let g:tmuxline_powerline_separators = 0

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier-standard']
let g:ale_fixers.json = ['prettier']
let g:ale_fixers.html = ['prettier']
let g:ale_fixers.css = ['prettier']
let g:ale_fixers.markdown = ['prettier']
let g:ale_fixers.python = ['black', 'isort']

let g:ale_linters = {}
let g:ale_linters.javascript = []
let g:ale_linters.python = ['flake8']
let g:ale_linters.markdown = ['write-good']

let g:ale_fix_on_save = 1
" }}}

" auto commands {{{
autocmd QuickFixCmdPost *grep* cwindow
" }}}

" mappings {{{
inoremap kj <esc>

nnoremap <leader>mv :vsplit $MYVIMRC <cr>
nnoremap <leader>ms :source $MYVIMRC <cr>

nnoremap <SPACE> <Nop>

nnoremap <leader>n :Explore <cr>

nmap <leader>d <Plug>DashSearch
" }}}

" vim {{{
augroup vim
	autocmd FileType vim setlocal foldmethod=marker
augroup END " }}}

" javascript {{{
augroup javascript
	autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END " }}}

" html {{{
augroup html
	autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" css {{{
augroup css
	autocmd FileType css setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" htmldjango {{{
augroup htmldjango
	autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" json {{{
augroup json
	autocmd BufNewFile,BufRead .jsbeautifyrc setfiletype json
	autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" yaml {{{
augroup yaml
	autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" hcl {{{
augroup hcl
	autocmd BufNewFile,BufRead *.hcl setfiletype hcl
	autocmd FileType hcl setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" mail {{{
augroup mail
	autocmd FileType mail setlocal textwidth=72 formatoptions+=aw
augroup END " }}}

" Vagrantfile {{{
augroup Vagrantfile
	autocmd BufNewFile,BufRead Vagrantfile setfiletype ruby
augroup END " }}}

" markdown {{{
augroup markdown
	autocmd FileType markdown nnoremap <buffer> <localleader>d :MarkdownPreview<CR>
	autocmd FileType markdown nnoremap <buffer> <localleader>s :MarkdownPreviewStop<CR>
	autocmd FileType markdown setlocal spell spelllang=en_us
augroup END " }}}

" text {{{
augroup markdown
	autocmd FileType text setlocal spell spelllang=en_us
augroup END " }}}

" c {{{
augroup c
	autocmd FileType c nnoremap <buffer> <localleader>c :make!<CR>
augroup END " }}}
