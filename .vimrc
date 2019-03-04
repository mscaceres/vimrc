set nocompatible
syntax enable
filetype plugin on

set runtimepath^=~/.vim/bundle/yaml-vim/autoload

set ls=2
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" "Used for serching files, looks inside of the current folder recursivelly
set path+=**
" "show completions menus/paths in a menu like format
set wildmenu

" "sroll n lines before end 
set scrolloff=4
" "show search matches, show column at line X
set incsearch
set showmatch
set hlsearch
set colorcolumn=110

set splitbelow
set splitright


" "Use ack as grep program
" "I should be using a config file for all folder to avoid
set grepprg=ack\ --ignore-dir=bamboo-virtualenv\ --ignore-dir=bamboo_virtualenv\ --ignore-file=is:tags\ --nocolor\ --nogroup\ --column
" "Format of ack result so it is correctly displyes on quickfix window
set grepformat=%f:%l:%c:%m

" "Always show quickfix window if we have something to show
augroup myvimrc
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow 20
	autocmd QuickFixCmdPost l*    lwindow 20
augroup END

let mapleader = ","

" "search word under curson with ack, redraw code window
map <leader>f :execute "silent grep! " . expand("<cword>") . " . " <CR><C-W><Up><C-L><C-W><Down>

" "run test under cursor
map <leader>rt :execute "!pytest %::" . expand("<cword>") 

" "run test file
map <leader>rf :execute "!pytest %"

" "Trim spaces and tabs before saving python files
autocmd BufWritePre *.py :%s/\s\+$//eg

" "Insert a python breakpoint in the line above
noremap <leader>b Oimport pdb;pdb.set_trace()<ESC>

" "offer tags for word under cursor
map <leader>ts :ts <C-r><C-w><CR>

" "run ctags on current folder
command! MakeTags !ctags -R --exclude=bamboo* --exclude=*.pyc --exclude=*.orig --exclude=make_base .

let python_highlight_all=1
syntax on

" "show line numbers
set nu

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" "add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


Plugin 'tmhedberg/SimpylFold'
" "Do not fold at opening files
set foldlevel=99

Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1

Plugin 'vim-syntastic/syntastic'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

Plugin 'scrooloose/nerdtree'

" "nerdtree configs
let NERDTreeIgnore=['\.pyc$', '\~$', 'bamboo*[[dir]]', '\.orig$', 'make-base[[dir]]', 'make_base[[dir]]'] "ignore files in NERDTree
silent! nmap <C-b> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>


" "syntastic configs
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors=1
let g:syntastic_python_checkers = ["flake8", "python"]


Plugin 'bennyyip/vim-yapf'

" "TODO:
" " *Buscar como desactivar este feature on demand, por ahi es medio tedioso
" " *mapear el :w para que trimee espacios !!!!

