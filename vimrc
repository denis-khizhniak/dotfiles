"""""""""""""""""""""""""""""""""""
" ~/.vimrc
"""""""""""""""""""""""""""""""""""

" ===== Vundle =====
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/share/vim/vim81/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" SQL code completion system using the omnifunc framework'
Plugin 'SQLComplete.vim'
" Provides database access to many dbms (Oracle, Sybase, Microsoft, MySQL, DBI,..)
Plugin 'dbext.vim'
" Zoom in/out of windows (toggle between one window and multi-window)
Plugin 'ZoomWin'
" vim-based archiver: builds, extracts, and previews
Plugin 'Vimball'
" A Git wrapper
Plugin 'tpope/vim-fugitive'
" A code-completion engine for Vim
Plugin 'valloric/youcompleteme'
" quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'
" enable repeating supported plugin maps with "."
Plugin 'tpope/vim-repeat'
" gruvbox colorscheme
Plugin 'morhetz/gruvbox'
" spacegray colorscheme
Plugin 'ajh17/spacegray.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" ===== dbext plugin settings =====
" DB profiles for dbext
" see https://www.vim.org/scripts/script.php?script_id=356
" Examples:
" let g:dbext_default_profile_mySQLServer = 'type=SQLSRV:integratedlogin=1:srvname=mySrv:dbname=myDB' 
" let g:dbext_default_profile_myORA = 'type=ORA:srvname=zzz42ga:user=john:passwd=whatever'
let g:dbext_default_SQLSRV_bin = 'mssql-wrapper.sh'
let g:dbext_default_SQLSRV_cmd_options = ' '
let g:dbext_default_profile_GLIC_dev2glimssql01_APP62 = 'type=SQLSRV:srvname=dev2glimssql01.eqxdev.exigengroup.com:user=APP62_datamart:passwd=APP62_datamart'
let g:dbext_default_profile_GLIC_dev2glimssql01_APP63 = 'type=SQLSRV:srvname=dev2glimssql01.eqxdev.exigengroup.com:user=APP63:passwd=app63'
let g:dbext_default_profile_GLIC_dev2glimssql01_sa_APP62 = 'type=SQLSRV:srvname=dev2glimssql01.eqxdev.exigengroup.com:user=sa:passwd=.3x1g3n:dbname=APP62'
let g:dbext_default_profile_GLIC_dev2glimssql02_APP41 = 'type=SQLSRV:srvname=dev2glimssql02.eqxdev.exigengroup.com:user=APP41:passwd=app41'
" set default profile
let g:dbext_default_profile = 'GLIC_dev2glimssql01_sa_APP62'

" ===== System =====
" use Vim defaults instead of 100% vi compatibility
set nocompatible
" do not keep a backup file, use versions instead
set nobackup 
" display info about commands
set showcmd
" display all matching files when we tab complete; show options above command line in autocomplete
set wildmenu
" don't redraw while executing macros (good performance config)
set lazyredraw 
" codesets and fileformats
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866
" enable filetype plugin
filetype plugin on              
" fix meta-keys which generate <Esc>a .. <Esc>z
let chr = 'a'
while chr <= 'z'
    exec "set <M-".chr.">=\e".chr
    exec "imap \e".chr." <M-".chr.">"
    let chr = nr2char(1+char2nr(chr))
endw
" time out for key codes
set ttimeout
" wait up to 100ms after Esc for special key
set ttimeoutlen=100
" set scroll bind option to horisontal by default
set scrollopt=hor
set scrollbind
" copy to system clipboard
set clipboard=unnamedplus
" insert the longest common text of all matches; and the menu will come up even if there's only one match
" set completeopt=longest,menuone

" ===== Look and Feel =====
" set color scheme
try
    colorscheme gruvbox
catch
    colorscheme desert
endtry
let g:gruvbox_contrast_dark="hard"
set bg=dark
" enable syntax highlighting
syntax on                       
" set relative line numbers and automatic toggle
set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" ===== Dictionaries =====
" set keymaps for russian keys in normal mode and search, toggle layout by Ctrl+^
set keymap=russian-jcukenwin 
" set latin keys as primary for insert
set iminsert=0
" set latin keys as primary for search
set imsearch=0

" ===== Shortcuts =====
" with a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','
" fast saving
nnoremap <leader>w :w!<cr>      
" quit without saving
nnoremap <leader>q :q!<cr>
" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null
" map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$
" map <Space> to scroll page down and <Ctrl>-<Space> to scroll page up
nnoremap <Space> <C-d>
nnoremap <C-@> <C-u>
" toggle english and russian with "ё" check spelling 
nnoremap <F3> :setlocal spell! spelllang=ru_yo,en_us<CR>

" ===== Autoreplace =====
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
autocmd BufReadCmd *.sql :call SetSQLAutoreplaceBindings()

" ===== Search =====
" Search down into subfolders, provides tab-completion for all file-related tasks
set path+=**
set hlsearch
set incsearch
set ignorecase
" show matching brackets when text indicator is over them
set showmatch 
" disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" ===== Formatting =====
" tab settings
set softtabstop=4
set shiftwidth=4
set smarttab
" use spaces instead of tabs
set expandtab 
" indentation and wrapping
set ai
set si
set wrap
" how many tenths of a second to blink when matching brackets
set mat=2
" set a character to show for everything BUT whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F6> :set list!<CR>
inoremap <F6> <C-o>:set list!<CR>
cnoremap <F6> <C-c>:set list!<CR>

" ===== Editing =====
" more powerful backspacing
set backspace=indent,eol,start
" use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" move a line of text using alt+[jk]
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
" indentation
inoremap <C-Tab> <C-t> " not working
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" retain visual selection after indent
vnoremap > >gv
vnoremap < <gv
" delete trailing white space on save, useful for python and coffeescript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
" convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" only define it when not defined already.
" revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" ===== Status =====
" status bar: filename, string format (DOS/UNIX) current row/column number, total rows
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [LEN=%L]
" show custom status bar
set laststatus=2

" ===== Tabs =====
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose!<CR>

" ===== Windows =====
nnoremap <C-Tab> <C-w>w   " not working
" split vertically
nnoremap <Bar> <C-w>v<C-w><Right>
" split horizontally
nnoremap -     <C-w>s<C-w><Down>
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
" zoom current window
nnoremap <silent> <C-w>w :ZoomWin<CR>

" ===== Execution =====
" write and execute current script
nnoremap <F5> <Esc>:w<CR>:!./%<CR>
inoremap <F5> <Esc>:w<CR>:!./%<CR>
" execute selected
noremap <leader>p :w !python<cr>
noremap <leader>b :w !bash<cr>

" ===== Navigation =====
" scroll 40 characters to the right
nnoremap <C-L> 40zl
" scroll 40 characters to the left
nnoremap <C-H> 40zh
