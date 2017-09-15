set nocompatible

set t_Co=256

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'

call vundle#end()

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set showcmd
"Highlight search
set hlsearch
"Highlight as you type
set incsearch
"Case insensitve search
set ignorecase
"Capitals are case matched in search
set smartcase
"Press \q to clear search highlight
nmap \q :nohlsearch
set autoindent

"Makes autocomplete vertically expand
set wildmenu

"Ruler!
set ruler

"This helps us avoid press enter to continue issues.
set laststatus=2

"Used to enable paste mode which prevents vim from messing with pasted text.
set pastetoggle=<C-w>

"This makes vim prompt on exit instead of auto fail
set confirm

"Disables that annoying bell.
set visualbell
"Disables that annoying flash
set t_vb=

"Saves the last two comands.
set cmdheight=2

"Tabs should expand to four spaces.
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

set backspace=indent,eol,start
set complete-=i

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

"Sets the default theme to solarize. This doesnt work everywhere
"set background=dark
"colorscheme solarized

colorscheme jellybeans

"This makes vim use the system clipboard for yank and paste.
set clipboard=unnamed

let g:user_emmet_leader_key='<C-Z>'

"Map leader key to space.
let mapleader = " "

set scrolloff=1
set sidescrolloff=5
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

"Delete comment character when joining commented lines
set formatoptions+=j

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set shell=/bin/bash

set autoread

set history=1000

set tabpagemax=50

set viminfo^=!
set sessionoptions-=options

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" have Y behave analogously to D and C rather than to dd and cc (which is already done by yy):
noremap Y y$

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>
" have <Tab> (and <Shift>+<Tab> where it works) change the level of indentation:
inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clears search buffer.
nmap <silent> <Leader><Enter> :nohlsearch<CR>

" Lets you save a file when you forgot to sudo
cmap w!! w !sudo tee % >/dev/null

" Configure Ctrl P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Rebind tab navigation
nnoremap <leader>tl  :tabnext<CR>
nnoremap <leader>th  :tabprev<CR>
nnoremap <leader>tn  :tabnew<CR>
nnoremap <leader>tc  :tabclose<CR>

" Easy search and replace shortcuts
nnoremap // *
nnoremap /? yiw:%s/<c-r>"/

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nnoremap ; :

" Emmet config
" Rebind leader to C-z
let g:user_emmet_leader_key='<C-Z>'

" Auto indents and completes {} pair
inoremap {<CR> {<CR>}<c-o>O<tab>

" exit with leader.
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>w :w<CR>

autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
