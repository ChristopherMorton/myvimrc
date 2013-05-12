"
" My vim file
"
" Stolen in large part from various places on the web
"
" Used/Maintained by: Christopher Morton <contact@cgmorton.com>


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Some stuff recommended by Steve Losh's 'Coming Home to Vim'
set encoding=utf-8
set scrolloff=3
set showmode
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set laststatus=2
set relativenumber
set undofile

" Leader-related stuff
let mapleader = ","

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Tab, indent stuff
set expandtab
set shiftwidth=3
set tabstop=3
set smarttab

" Searching stuff
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set showmatch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" less keystrokes for commands
nnoremap ; :

au FocusLost * :wa

" Use 'yy' or 'jj' as another 'ESC'
inoremap yy <ESC>
inoremap jj <ESC>

" Split window shortcuts
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set backupdir=~/.vim/backup/temp

" Remaps up/down to move view up/down, S-up/down for normal behavior
map <Down> <C-e>
map <Up> <C-y>
map <S-Down> j
map <S-Up> k

" Create ctags file in current directory
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" space = center screen on current line
map <Space> zz

" C++ print-debug macro in @p, undo said macro with @o
let @p='yyP:s/\\/\\\\/ge:s/\"/\\\"/geIstd::cout << "f;C" << std::endl;jIstd::cout << (f;C) << std::endl; // print-debug'
let @o='kdddf(f)C;'


" Plugins
call pathogen#infect()

" Tab management stuff
nnoremap <leader>t :tabedit 
nnoremap <leader>n :tabnext<cr>
nnoremap <leader>p :tabprevious<cr>

nnoremap <leader>f :FufFile
" let vimclojure#WantNailgun = 1

nnoremap <leader><space> :noh<cr>

colorscheme mustang

" Colemak remappings
" nnoremap l l
vnoremap k j
vnoremap e k
vnoremap j e
vnoremap K J
nnoremap k j
nnoremap e k
nnoremap j e
nnoremap K J
" windows
nnoremap <C-k> <C-w>j
nnoremap <C-e> <C-w>k

" bracket remappings:
inoremap [ (
inoremap { )
inoremap ] [
inoremap } ]
inoremap ( {
inoremap ) }
