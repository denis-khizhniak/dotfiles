"""""""""""""""""""""""""""""""""""
" ~/.vimrc
"""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
" let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Tab settings
set tabstop=2
set shiftwidth=2
set smarttab

" Use spaces instead of tabs
set expandtab

" Indentation and wrapping
set ai
set si
set wrap

" Show options above command line in autocomplete
set wildmenu

" Display line numbers on the left
set number

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" Search settings
set hlsearch
set incsearch
set ignorecase

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" Codesets and fileformats
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Set color scheme for text selection
try
  colorscheme desert
catch
endtry

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Status bar: filename, string format (DOS/UNIX) current row/column number, total rows
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [LEN=%L]

" Show custom status bar
set laststatus=2

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
