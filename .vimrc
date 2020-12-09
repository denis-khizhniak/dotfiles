"""""""""""""""""""""""""""""""""""
" ~/.vimrc
"""""""""""""""""""""""""""""""""""

" ===== ale ===== {{{
" setting this variable before loading ALE Plugin as per documentation
let g:ale_completion_enabled = 1
" ===== ale ===== }}}
" ===== Plugins ===== {{{
call plug#begin('~/.vim/plugged')

" A Git wrapper
Plug 'tpope/vim-fugitive'

" A code-completion engine for Vim
Plug 'valloric/youcompleteme', { 'do': './install.py' }

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Enable repeating supported Plug maps with "."
Plug 'tpope/vim-repeat'

" Commenting out
Plug 'tpope/vim-commentary'

" Easy code formatting integrating existing code formatters
Plug 'chiel92/vim-autoformat'

" Toggle display and navigate marks
Plug 'kshenoy/vim-signature'

" Status/tabline for vim
Plug 'vim-airline/vim-airline'

" Themes for airline
Plug 'vim-airline/vim-airline-themes'

" Helpers for UNIX
Plug 'tpope/vim-eunuch'

" Emmet for vim
Plug 'mattn/emmet-vim'

" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
Plug 'w0rp/ale'

" Git diff in the gutter
Plug 'airblade/vim-gitgutter'

" Automatic keyboard layout switching in INSERT mode
Plug 'lyokha/vim-xkbswitch'

" Highlight the color codes and names with the respective colors
Plug 'chrisbra/colorizer'

" Alignment plugin
Plug 'junegunn/vim-easy-align'

" Use LS_COLORS in your vidir session inside vim
Plug 'trapd00r/vim-syntax-vidir-ls'

" A command-line fuzzy finder
Plug 'junegunn/fzf'

" Use nnn as a file picker
Plug 'mcchrish/nnn.vim'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" gruvbox theme
Plug 'morhetz/gruvbox'

Plug 'moll/vim-bbye'
Plug 'aymericbeaumet/vim-symlink'

call plug#end()
" ===== Plugins ===== }}}
" ===== System ===== {{{
" Use 24-bit color
" set termguicolors
" let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"                                                                                        
" let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" Use Vim defaults instead of 100% vi compatibility
set nocompatible

" Do not keep a backup file, use versions instead
set nobackup

" Display info about commands
set showcmd

" Display all matching files when we tab complete; show options above command line in autocomplete
set wildmenu

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Codesets and fileformats
set ffs=unix,dos,mac
set fencs=ucs-bom,utf-8,utf-16le,cp1251,koi8-r,default,latin1
" set fencs=ucs-bom,utf-8,cp1251,koi8-r,default,latin1

" Enable filetype plugin and indent
filetype plugin indent on

" Fix meta-keys which generate <Esc>a .. <Esc>z
let chr = 'a'
while chr <= 'z'
    exec "set <M-".chr.">=\e".chr
    exec "imap \e".chr." <M-".chr.">"
    let chr = nr2char(1+char2nr(chr))
endw

" Time out for key codes
set ttimeout

" Wait up to 100ms after Esc for special key
set ttimeoutlen=100

" Set scroll bind option to horisontal by default
set scrollopt=hor
set scrollbind

" Copy to system clipboard
set clipboard=unnamedplus

" Insert the longest common text of all matches; and the menu will come up even if there's only one match
" set completeopt=longest,menuone

" Set UTF-8 encoding
set encoding=utf-8

set updatetime=100

" With a map leader it's possible to do extra key combinations
let mapleader = ','

" Set number of colors
set t_Co=256

" Automatically save changes to the buffer
set autowrite

" Function for handling URLs
function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!xdg-open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction
" map gx :call HandleURL()<cr>
nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>

" Set working directory to follow current buffer
set autochdir

" Ignore case completing file names
set wildignorecase

" Wipe all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Copy file name/full path to clipboard
nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>
" ===== System ===== }}}
" ===== Look and Feel ===== {{{ 
" Set color scheme 
colorscheme default

" Set colors suitable for dark background
set background=dark

" Set bg=dark
" Enable syntax highlighting
syntax on

" Set relative line numbers
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd InsertLeave,WinEnter * set relativenumber
    autocmd InsertEnter,WinLeave * set number norelativenumber
augroup END

" Toggle cursor line highlighting
nnoremap <leader>c :set cursorline! <CR>

" Define the active completion line to use specified colors for the selected completion option
hi PmenuSel ctermfg=3 ctermbg=0

" Set spell checking with "ё"
set spelllang=ru_yo,en_us

" Always open buffer with spell checking off
augroup opennospelling
    autocmd!
    autocmd BufEnter * set nospell
augroup END

" Disable highlighting when entering insert mode
autocmd InsertEnter * :let @/=''
" ===== Look and Feel ===== }}}
" ===== Dictionaries ===== {{{
" Set keymaps for russian keys in normal mode and search, toggle layout by Ctrl+^
set keymap=russian-jcukenwin

" Set latin keys as primary for insert
set iminsert=0

" Set latin keys as primary for search
set imsearch=0
" ===== Dictionaries ===== }}}
" ===== Shortcuts ===== {{{
" Fast saving and disable highlighting
nnoremap <leader>w :w!<CR>:let @/=''<CR>

" Fast reopen and disable highlighting
nnoremap <leader>e :e!<CR>:let @/=''<CR>

" Quit without saving
nnoremap <leader>q :q!<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$

" Toggle english and russian with "ё" check spelling
nnoremap <F3> :setlocal spell!<CR>

" Enter fzf shell
noremap ; :FZF ~<CR>

" Force spell checking and invoke the completion from dictionaries
inoremap <C-Space> <C-o>:setlocal spell<CR><C-X><C-K>

" Toggle wrap
nnoremap <F9> :set wrap!<CR>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Select all
nnoremap <M-a> ggVG

" Open netrw
nnoremap <F2> :Vexplore<CR>

" Toggle Vexplore
nnoremap <silent> <F2> :call ToggleVExplorer()<CR>
" ===== Shortcuts ===== }}}
" ===== Autoreplace ===== {{{
" SQL specific bindings
func! SetSQLAutoreplaceBindings()
    iab sf select * from
    iab scf select count(1) from
    iab ij join
    iab lj left join
    iab rj right join
    iab fj full join
    iab cj cross join
    iab c1 count(1)
    iab gb group by
    iab ob order by
    iab hcg1 having count(1) > 1
    iab sd select distinct
    iab wh where
    iab nnl is not null
    iab nl is null
    iab sel select
    iab alt alter table
    iab crt create table
    iab drt drop table
    iab df delete from
    iab tt truncate table
    iab stf select top 100 * from
    iab selt select top 100
    iab lk like '%%'
endfunc

func! SetJavaAutoreplaceBindings()
    iab psvm public static void main(String[] args) {<CR>
    iab cl class
    iab pub public
    iab pri private
    iab sout System.out.println(%)<Esc>F%s<C-o>:call getchar()<CR>
endfunc

autocmd BufNewFile,BufRead *.sql :call SetSQLAutoreplaceBindings()
autocmd BufNewFile,BufRead *.java :call SetJavaAutoreplaceBindings()

" remap 'open man page' to Ctrl-K
nnoremap <C-K> :execute "tab h " . expand("<cword>")<cr>

" go to next buffer
nnoremap <C-n> :bnext<CR>
" go to previous buffer
nnoremap <C-p> :bprevious<CR>
" delete buffer
nnoremap <leader>x :bdelete<CR>
" ===== Autoreplace ===== }}}
" ===== Search ===== {{{
" Search down into subfolders, provides tab-completion for all file-related tasks
set path+=**

set hlsearch
set incsearch
set ignorecase

" Automatically switch search to case-sensitive when search query contains an uppercase letter
set smartcase

" Show matching brackets when text indicator is over them
set showmatch

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>
" ===== Search ===== }}}
" ===== Formatting ===== {{{
" Tab settings
set softtabstop=4
set shiftwidth=4
set smarttab

" When shifting lines, round the indentation to the nearest multiple of 'shiftwidth'
set shiftround

" Use spaces instead of tabs
set expandtab

" Indentation and wrapping
set autoindent
set si
set wrap

" How many tenths of a second to blink when matching brackets
set mat=2

" Set a character to show for everything BUT whitespace
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:␣
noremap <F6> :set list!<CR>
inoremap <F6> <C-o>:set list!<CR>
cnoremap <F6> <C-c>:set list!<CR>

" Format a source code with
noremap <leader>f :Autoformat<CR>

" Fol unchanged lines tracked by git
noremap <leader>g :GitGutterFold<CR>

" Avoid wrapping a line in the middle of a word
set linebreak

" Disable insertion of comment leader after 'O' or heating <Enter> for
" Vimscript files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal formatoptions-=ro
augroup END

" Delete comment characters when joining lines
set formatoptions+=j

" Set linters and fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'bash': ['shfmt'],
\   'sh': ['shfmt'],
\   'java': ['uncrustify'],
\}

" Save folds on exit and load them on enter
augroup remember_folds
  autocmd!
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent! loadview
augroup END
" ===== Formatting ===== }}}
" ===== Editing ===== {{{
" More powerful backspacing
set backspace=indent,eol,start

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Move a line of text
nnoremap <leader><A-j> :m .+1<CR>==
nnoremap <leader><A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Indentation
inoremap <C-Tab> <C-t> " Not working
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Retain visual selection after indent
vnoremap > >gv
vnoremap < <gv

" Delete trailing white space on save, useful for python and coffeescript ;)
func! DeleteTrailingWS()
    %s/\s\+$//ge
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Convenient command to see the difference between the current buffer and the
" File it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Break the current line in normal mode
nnoremap <M-b> i<CR><ESC>

" Fix current buffer with ALE
nmap <F8> <Plug>(ale_fix)

" Allow to move to the end of line plus one position more
set virtualedit=onemore

" Add empty line before/after current line
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Delete a character at cursor
inoremap <C-d> <ESC>ls

" Delete a word after cursor
inoremap <A-d> <ESC>lcw
" ===== Editing ===== }}}
" ===== Status ===== {{{
" Status bar: filename, string format (DOS/UNIX) current row/column number, total rows
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [LEN=%L]

" Show custom status bar
set laststatus=2
" ===== Status ===== }}}
" ===== Tabs ===== {{{
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose!<CR>
" ===== Tabs ===== }}}
" ===== Windows ===== {{{
nnoremap <C-Tab> <C-w>w   " Not working

" Split vertically
nnoremap <Bar> <C-w>v<C-w><Right>

" Split horizontally
nnoremap -     <C-w>s<C-w><Down>

" Maximize current window
nnoremap <silent> <C-w>w <C-w>_ <C-w>\|

" Automatically re-read files if they were modified outside of vim
set autoread
" ===== Windows ===== }}}
" ===== Buffer execution ===== {{{
" Save and execute the buffer withing extra applications
noremap <leader>p :w! \| :new \| 0r !python #<CR>
noremap <leader>b :w! \| :new \| 0r !bash #<CR>
noremap <leader>j :w! \| :new \| 0r !javac #; java $(basename # .java)<CR>

" Save and execute the buffer by F5 according to the filetype
autocmd BufNewFile,BufRead *.java noremap <F5> :w! \| :new \| 0r !javac #; java $(basename # .java)<CR>
autocmd BufNewFile,BufRead *.python noremap <F5> :w! \| :new \| 0r !python #<CR>
autocmd BufNewFile,BufRead *.sh noremap <F5> :w! \| :new \| 0r !bash #<CR>
" ===== Buffer execution ===== }}}
" ===== Navigation ===== {{{
" Scroll 40 characters to the right
nnoremap <A-L> 40zl

" Scroll 40 characters to the left
nnoremap <A-H> 40zh
" ===== Navigation ===== }}}
" ===== YouCompleteMe ===== {{{
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" ===== YouCompleteMe ===== }}}
" ===== Java Decompiler ===== {{{
augroup class
    autocmd!
    " autocmd bufreadpost,filereadpost *.class silent %!cfr -noctor -ff -i -p %
    autocmd BufReadPost,FileReadPost *.class silent %!cfr %
    autocmd BufReadPost,FileReadPost *.class set readonly
    autocmd BufReadPost,FileReadPost *.class set ft=java
    autocmd BufReadPost,FileReadPost *.class normal gg=G
    autocmd BufReadPost,FileReadPost *.class set nomodified
augroup END
" ===== Java Decompiler ===== }}}
" ===== netrw ===== {{{
" Set tree view for netrw by default
let g:netrw_liststyle = 3

" Remove the banner in netrw
let g:netrw_banner = 0

" Open files in previous window
let g:netrw_browse_split = 4

let g:netrw_altv = 1
let g:netrw_winsize = 25

" Toggle Vexplore
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
" ===== netrw ===== }}}
" ===== nnn ===== {{{
" Start nnn in the current file's directory
nnoremap <leader>n :NnnPicker '%:p:h'<CR>

" Opens the nnn window in a split
let g:nnn#layout = 'new'
" ===== nnn ===== }}}
" ===== gruvbox ===== {{{
autocmd vimenter * ++nested colorscheme gruvbox
" ===== gruvbox ===== }}}
" ===== airline ===== {{{
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" Set format for for path for airline formatter
let g:airline#extensions#tabline#formatter = 'default'

" Populate the g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1

" Load only specified extensions for airline
let g:airline_extensions = ['branch', 'tabline']

" Set theme for airline
let g:airline_theme='minimalist'
" ===== airline ===== }}}
