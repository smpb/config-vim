" set Pathogen to load all scripts on ~/vim/bundle/
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()


"========[ VIM SETTINGS ]========

set nocompatible
set ttyfast
set encoding=utf-8
set fileformats=unix,mac,dos  " handle Mac and DOS line-endings
                              " but prefer Unix endings

" show visual bell instead of beeping
" don't beep on error
set visualbell
set noerrorbells

" look of the windows
set showmode
set showcmd
set nonumber
set ruler
set scrolloff=3   " number of screen lines to keep above and below the cursor
set laststatus=2  " the last window always has a status bar

" deal with tabs and indentation
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab
set autoindent
set smartindent

" deal with long lines
"set formatoptions-=cro " do ':help fo-table' for details
"set textwidth=120
"set wrap

" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

augroup VisibleNaughtiness
  " Remove ALL autocommands for the current group,
  " to ensure that Vim includes the autocommands only once
  autocmd!

  autocmd BufEnter  *     set list
  autocmd BufEnter  *     if !&modifiable
  autocmd BufEnter  *       set nolist
  autocmd BufEnter  *     endif
augroup END

" backspace allowed over autoindent,
" over EOL - joining lines, over the start of insert
set backspace=indent,eol,start

" autocomplete commands with <Tab>
" present more than one match in a list, complete with longest match
set wildmenu
set wildmode=list:longest,full  " show list of completions:
                                " and complete as much as possible,
                                " then iterate full completions


"========[ SEARCH OPTIONS ]========

set ignorecase  " ignore case in all searches...
set smartcase   " ...unless uppercase letters used
set incsearch   " lookahead as search pattern is specified
set hlsearch    " highlight all matches

" delete in normal mode to switch off highlighting till next search
nmap <silent> <BS> :nohlsearch<CR>


"========[ PATHS SETUP ]========

"" extra forward slash to specify that VIM should add the full path to the filename
"set backup
"set backupdir=$HOME/.vim/backups/
"set directory=$HOME/.vim/swaps/
"set viewdir=$HOME/.vim/views/

"" activate 'semi-infinite' undo, if available
"if has('persistent_undo')
"  set undodir=$HOME/.vim/undodir/
"  set undolevels=1000
"  set undofile
"endif


"========[ GENERIC KEY MAPPINGS ]========

" remap leader key - user commands
" Example, >:map <Leader>A  oanother line<Esc>
" works like, >:map ,A  oanother line<Esc>
let mapleader=","

" remap bracket matching to the Tab key
nnoremap <TAB> %
vnoremap <TAB> %

" enable tab-browsing
nmap <C-TAB>    :tabnext<CR>
nmap <C-S-TAB>  :tabprevious<CR>

" 'very magic' mode for regular expression patterns
" ie, regex work almost exactly like in Perl
nnoremap / /\v
vnoremap / /\v

" Make backspace work as expected in visual modes,
" i.e. delete the selected text
vmap <BS> x

" Use (shift+)space to jump through the page (like browsers do)
nnoremap <Space>    <PageDown>
nnoremap <S-Space>  <PageUp>


"========[ GUI OPTIONS ]========

if has("gui_running")
  set guioptions-=T  "remove toolbar
  "set guioptions-=m  "remove all scroll bars
  "set guioptions-=l  "remove all scroll bars
  "set guioptions-=r  "remove all scroll bars
  "set guioptions-=b  "remove all scroll bars

  set guifont=Input\ Mono:h14
endif

if &t_Co >= 256 || has("gui_running")
  let g:solarized_italic=0
  let g:solarized_termcolors=256
  let g:airline_theme="solarized"

  set background=dark
  colorscheme solarized
elseif has('termguicolors')
  set termguicolors
endif


"========[ TERMINAL SETTINGS ]========

" open terminal below all splits
cabbrev bterm bo term
map <Leader>t :bterm ++close<CR>


"========[ FILE SETTINGS ]========

" autosave and autoload file views (to maintain folds)
" autocmd BufWinLeave ?* mkview
" autocmd BufWinEnter ?* silent loadview

filetype on         " try to detect the file type when opened,
filetype plugin on  " enable loading the plugin files,
filetype indent on  " and ident rules for specific file types

syntax enable       " switch syntax highlighting on

" folding
"set foldcolumn=1
"set foldmethod=syntax

" open all folds by default
"autocmd BufWinEnter * normal zR


"========[ MARKDOWN FILES ]========

" my *.md files are, by default, Markdown files
autocmd BufRead,BufNewFile *.md setfiletype markdown


"========[ OBJC FILES SETTINGS ]========

" my *.m files are, by default, Objective-C files
autocmd BufRead,BufNewFile *.m setfiletype objc


"========[ PERL FILES SETTINGS ]========

"let perl_fold = 1             " syntax folding for Perl files
"let perl_nofold_packages = 1  " don't fold packages

" these files are, by default, Perl files
autocmd BufNewFile,BufRead *.t set filetype=perl
autocmd BufNewFile,BufRead *.bml set filetype=perl tabstop=4 shiftwidth=4


" Execute Perl file...
nmap W :!clear;echo;echo;perl %;echo;echo;echo<CR>

" Execute Perl file (output to pager)...
nmap E :!perl -m %<CR>

" Execute Perl file (in debugger)...
nmap Q :!perl -d %<CR>


"========[ SHELL FILES ]========

" my *.zshrc files are, by default, zsh files
autocmd BufRead,BufNewFile *.zshrc setfiletype zsh


"========[ AIRLINE SETTINGS ]========

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


"========[ NERDTREE SETTINGS ]========

nmap <Leader>p :NERDTree<CR>


"========[ TAGBAR SETTINGS ]========

nmap <Leader>l :TagbarToggle<CR>


"========[ GIT-GUTTER SETTINGS ]========

highlight clear SignColumn
highlight SignColumn            ctermbg=black
highlight GitGutterAdd          ctermfg=green   guifg=darkgreen
highlight GitGutterChange       ctermfg=yellow  guifg=darkyellow
highlight GitGutterDelete       ctermfg=red     guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow  guifg=darkyellow

