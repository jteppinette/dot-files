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
Plug 'nvie/vim-flake8'
Plug 'fisadev/vim-isort'
Plug 'arcticicestudio/nord-vim'
Plug 'rizzatti/dash.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'maksimr/vim-jsbeautify'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'plytophogy/vim-virtualenv'
Plug 'edkolev/tmuxline.vim'
Plug 'iamcco/markdown-preview.vim'
Plug 'elixir-editors/vim-elixir'
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

let g:vim_isort_python_version = 'python3'

let g:flake8_show_in_gutter = 1

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:autoformat_verbosemode=0
let g:formatdef_fixed_css_beautify = '"css-beautify -f- -s ".shiftwidth()'
let g:formatters_css = ['fixed_css_beautify']
let g:formatters_htmldjango = []
let g:formatters_sh = []
" }}}

" auto commands {{{
autocmd QuickFixCmdPost *grep* cwindow
autocmd BufWritePre * :Autoformat
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
	autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 expandtab
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

" go {{{
augroup go
	autocmd FileType go autocmd BufWritePre <buffer> :normal! magggqG`a
augroup END " }}}

" python {{{
augroup python
	autocmd FileType python nnoremap <buffer> <localleader>c :make %<CR>:copen<CR>
	autocmd FileType python nnoremap <buffer> <localleader>f :call Flake8()<CR>
	autocmd BufWritePre *.py execute ':Isort'
	autocmd BufWritePost *.py call Flake8()
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

" jinja {{{
augroup jinja
	autocmd BufNewFile,BufRead *.jinja setfiletype htmldjango
augroup END " }}}

" Vagrantfile {{{
augroup Vagrantfile
	autocmd BufNewFile,BufRead Vagrantfile setfiletype ruby
augroup END " }}}

" markdown {{{
augroup markdown
	autocmd FileType markdown nnoremap <buffer> <localleader>d :MarkdownPreview<CR>
	autocmd FileType markdown nnoremap <buffer> <localleader>s :MarkdownPreviewStop<CR>
augroup END " }}}

" c {{{
augroup c
	autocmd FileType c nnoremap <buffer> <localleader>c :make!<CR>
augroup END " }}}
