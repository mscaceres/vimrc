set nocompatible
syntax enable
filetype plugin on
filetype indent on    " required
set ttyfast

set runtimepath^=~/.vim/bundle/yaml-vim/autoload

set cursorline
set signcolumn=yes
botright cwindow

set ls=2

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
set colorcolumn=100

set splitbelow
set splitright

set autoindent expandtab tabstop=4 shiftwidth=4
set softtabstop=4  " "Make backspace delete 4 spaces
set smartindent

set maxmempattern=3000
" "Use ack as grep program
" "I should be using a config file for all folder to avoid
" "set grepprg=ack\ --ignore-dir=.venv\ --ignore-dir=.mypy_cache\ --ignore-dir=.mypy-venv-public-api\ --ignore-dir=.mypy-venv\ --ignore-dir=.mypy-venv-devtools\ --ignore-file=is:tags\ --ignore-file=ext:orig\ --ignore-file=ext:pyc\ --nocolor\ --nogroup\ --column
" "Format of ack result so it is correctly displyes on quickfix window
set grepprg=rg\ --vimgrep 
set grepformat=%f:%l:%c:%m

" "Always show quickfix window if we have something to show
augroup myvimrc
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow 20
	autocmd QuickFixCmdPost l*    lwindow 20
augroup END

let mapleader = ","

" "search word under curson with ack, redraw code window
map <leader>ff :execute "silent grep! " . expand("<cword>") . " . " <CR><C-W><Up><C-L><C-W><Down>

" "search word under curson with ack, redraw code window
map <leader>f :execute "silent grep! -w " . expand("<cword>") . " . " <CR><C-W><Up><C-L><C-W><Down>

" "run test under cursor
map <leader>rt :execute "!pytest %::" . expand("<cword>") 
" "copy to clipboard test path <file_path>::<test_name>, so we can run it in
" docker
map <leader>ct :let @+=@% . "::" . expand("<cword>") 

" "run test file
map <leader>rf :execute "!pytest %"

" "Trim spaces and tabs before saving python files
autocmd BufWritePre *.py :%s/\s\+$//eg
map <leader>cs :%s/\s\+$//eg<CR> 

" "Insert a python breakpoint in the line above
noremap <leader>db Oimport pdb;pdb.set_trace()<ESC>

" "offer tags for word under cursor
map <leader>ts :tjump <C-r><C-w><CR>

" "run ctags on current folder
command! MakeTags !ctags -R --exclude=.venv --exclude=.mypy* --exclude=.pip* --exclude=*.pyc --exclude=*.orig .
command! LibTags !find `".venv/bin/python" -c "import distutils; print(distutils.sysconfig.get_python_lib())"` -name \*.py | ctags -L- --append


" "python visual selection comment/uncomment
vnoremap <leader>c :s/^/# /<CR>:noh<CR>
vnoremap <leader>C :s/\(^\)# /\1/<CR>:noh<CR>

" "replace word under cursor with single qoutes
noremap <leader>q bdei''<Esc>P

" "replace visual selection with single qoutes
vnoremap <leader>q di''<Esc>P

" "find services 
map <leader>l "ayi":split shiphero_app/shiphero_app/app_services.yaml<CR>/<c-r>a:<CR>j$b"

" "Run black on current file
map <leader>p :execute "!black %"<CR>


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

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
" "Some color schemas
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'patstockwell/vim-monokai-tasty'
Plugin 'scrooloose/nerdtree'

Plugin 'bennyyip/vim-yapf'
" "RST plugin
Plugin 'Rykka/riv.vim'

Plugin 'sheerun/vim-polyglot'
Plugin 'b4b4r07/vim-hcl'

Plugin 'davidhalter/jedi-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'preservim/tagbar'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'nvim-lua/plenary.nvim'


" " All of your Plugins must be added before the following line
call vundle#end()            " required

" "SimpylFold Do not fold at opening files
set foldlevel=99

" "syntastic configs
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors=1
let g:syntastic_python_checkers = ["python", "pylint"]
let g:syntastic_ignore_files = ['.venv/*']

" "colorcheme
colorscheme zenburn
let g:airline_theme = 'deep_space'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
 " "fix tmux colors
set background=dark
set t_Co=256

" "nerdtree configs
let NERDTreeIgnore=['\.pyc$', '\~$', '\.orig$'] "ignore files in NERDTree
silent! nmap <C-a> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>


" "tagBar configs
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_foldlevel = 1

set encoding=UTF-8
setlocal spell spelllang=en_us,es_es
set spell
set undofile
set undodir=~/.vim/undodir

