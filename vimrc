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
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'edkolev/tmuxline.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'ervandew/supertab'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'plytophogy/vim-virtualenv'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'yuezk/vim-js'
Plug 'davidhalter/jedi-vim'
Plug 'mileszs/ack.vim'
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
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set noshowmode

let maplocalleader = ","
let mapleader = " "

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1

let g:tmuxline_powerline_separators = 0

let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = "winwidth"
let g:jedi#show_call_signatures = 2
let g:jedi#usages_command = ""

let g:ale_fixers = {}
let g:ale_fixers.c = ['clang-format']
let g:ale_fixers.cpp = ['clang-format']
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.json = ['prettier']
let g:ale_fixers.html = ['prettier']
let g:ale_fixers.css = ['prettier']
let g:ale_fixers.scss = ['prettier']
let g:ale_fixers.markdown = ['prettier']
let g:ale_fixers.sh = ['shfmt']
let g:ale_fixers.zsh = ['shfmt']
let g:ale_fixers.python = ['black', 'isort']
let g:ale_fixers.yaml = ['prettier']
let g:ale_fixers.go = ['goimports']
let g:ale_fixers.sql = ['pgformatter']
let g:ale_fixers.java = ['google_java_format']
let g:ale_fixers.elixir = ['mix_format']

let g:ale_linters = {}
let g:ale_linters.java = []
let g:ale_linters.c = ['clangtidy']
let g:ale_linters.cpp = ['clangtidy']
let g:ale_linters.javascript = ['prettier']
let g:ale_linters.python = ['flake8', 'mypy']
let g:ale_linters.markdown = ['write-good']
let g:ale_linters.go = ['govet']

let g:ale_fix_on_save = 1
" }}}}

" rip grep integration {{{
if executable("rg")
	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
	let g:ctrlp_use_caching = 0

	let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
	let g:ack_autoclose = 1
	let g:ack_use_cword_for_empty_search = 1
	cnoreabbrev Ack Ack!
	nnoremap <C-r>/ :Ack!<Space>
endif
" }}}

" mappings {{{
inoremap kj <esc>

nnoremap <leader>mv :vsplit $MYVIMRC <cr>
nnoremap <leader>ms :source $MYVIMRC <cr>

nnoremap <SPACE> <Nop>

nnoremap <leader>n :Explore <cr>
" }}}

" pyindent {{{
let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'
"}}}

" vim {{{
augroup vim
	autocmd FileType vim setlocal foldmethod=marker
augroup END " }}}

" javascript {{{
augroup javascript
	autocmd BufNewFile,BufRead .jsx setfiletype javascript
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

" scss {{{
augroup scss
	autocmd FileType scss setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" htmldjango {{{
augroup htmldjango
	autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}

" json {{{
augroup json
	autocmd BufNewFile,BufRead .parcelrc setfiletype json
	autocmd BufNewFile,BufRead .jsbeautifyrc setfiletype json
	autocmd BufNewFile,BufRead .sassrc setfiletype json
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
	autocmd BufNewFile,BufRead *.h setfiletype c
	autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab
augroup END " }}}

" cpp {{{
augroup cpp
	autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 expandtab
augroup END " }}}

" go {{{
augroup go
	autocmd FileType go setlocal tabstop=4 shiftwidth=4
augroup END " }}}

" sql {{{
augroup sql
	autocmd FileType sql setlocal tabstop=4 shiftwidth=4
augroup END " }}}

" java {{{
augroup java
	autocmd FileType java setlocal tabstop=2 shiftwidth=2 expandtab omnifunc=javacomplete#Complete
augroup END " }}}

" lua {{{
augroup lua
	autocmd FileType lua setlocal shiftwidth=2 tabstop=2 expandtab
augroup END " }}}
