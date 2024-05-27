"========[ LOAD PLUGINS ]========

" set Pathogen to load all scripts on ~/vim/bundle/
"  https://github.com/tpope/vim-pathogen
execute pathogen#infect()


"========[ VIM SETTINGS ]========

set nocompatible
set ttyfast
set encoding=utf-8
set fileformats=unix,mac,dos  " handle Mac and DOS line-endings but prefer Unix endings
set updatetime=500            " save to swap faster, helping plugins tracking changes

" show visual bell instead of beeping
" don't beep on error
set visualbell
set noerrorbells

" look of the windows
set showmode
set showcmd
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

" spellchecking
set spelllang=en_us,pt_pt

" deal with long lines
"set formatoptions-=cro " do ':help fo-table' for details
"set textwidth=120
"set wrap

" backspace allowed over autoindent,
"  over EOL - joining lines, over the start of insert
set backspace=indent,eol,start

" autocomplete commands with <Tab>
"  present more than one match in a list, complete with longest match
set wildmenu
set wildmode=list:longest,full  " show list of completions:
                                " and complete as much as possible,
                                " then iterate full completions

" suppress 'No write since last change' when switching files/buffers
"  hidden - hide (but don't unload) unsaved buffers when abandoning them
set hidden

"========[ SEARCH OPTIONS ]========

set ignorecase  " ignore case in all searches...
set smartcase   " ...unless uppercase letters used
set incsearch   " lookahead as search pattern is specified
set hlsearch    " highlight all matches

" delete in normal mode to switch off highlighting till next search
nmap <silent> <BS> :nohlsearch<CR>

" configure 'n' to ALWAYS go forward regardless of how searching started
"  this uses expression-maps, which maps the left-hand side of the map to an expression that will be evaluated - see ':h map-expression'
"  v:searchforward variable (internal state of which direction the last search was, see ':h v:searchforward') is used as an index
"   if the last search direction was forward, the n will be mapped to 'n'
"   if it was backward, the 'n' will be mapped to 'N' (because the v:searchforward variable is 0)
"
" alternative equivalent:
"  nnoremap <expr> n 'Nn'[v:searchforward]
"  nnoremap <expr> N 'nN'[v:searchforward]
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')

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
"  example,     >:map <Leader>A  oanother line<Esc>
"  works like,  >:map ,A  oanother line<Esc>
let mapleader=","

" remap bracket matching to the Tab key
nnoremap <TAB> %
vnoremap <TAB> %

" enable tab-browsing
nmap <C-TAB>    :tabnext<CR>
nmap <C-S-TAB>  :tabprevious<CR>

" move to the next/previous buffer
nmap <Leader>;  :bnext<CR>
nmap <Leader>l  :bprevious<CR>

" 'very magic' mode for regular expression patterns
" ie, regex work almost exactly like in Perl
nnoremap / /\v
vnoremap / /\v

" make backspace work as expected in visual modes,
"  i.e. delete the selected text
vmap <BS> x

" use (shift+)space to jump through the page (like browsers do)
nnoremap <Space>          <PageDown>
nnoremap <S-Space>        <PageUp>
nnoremap <Leader><Space>  <PageUp>

" use shift+tab in Insert mode to trigger basic auto-complete
inoremap <S-Tab> <C-n>

"========[ GUI OPTIONS ]========

set colorcolumn=81,121

" replace the default split bar
set fillchars+=vert:\│

" make whitespace characters visible
set listchars=tab:\│\ ,trail:·,nbsp:~
set list

" toggle visible whitespace characters on and off
command ListToggle if &modifiable | if &list | set nolist | else | set list | endif | endif

" use relative line numbers when moving around in normal mode, but absolute ones in insert mode
set number
augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" toggle the numbers on and off
command NumbersToggle if &nu | set nonu | set nornu | else | set nu | set rnu | endif

" shortcut to toggle on and off all visual noise
map <Leader>n :NumbersToggle<CR>:ListToggle<CR>

" use rich colors when available
if has('termguicolors')
  set termguicolors
endif

if has("gui_running")
  set guioptions-=T  "remove toolbar
  "set guioptions-=m  "remove all scroll bars
  "set guioptions-=l  "remove all scroll bars
  "set guioptions-=r  "remove all scroll bars
  "set guioptions-=b  "remove all scroll bars

  set guifont=InputMono\ Nerd\ Font:h14
else
  " fix truecolor support inside tmux
  "  - https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
  if &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

let g:onedark_terminal_italics=0
let g:airline_theme="onedark"

set background=dark
colorscheme onedark

"========[ TERMINAL SETTINGS ]========

" open terminal below all splits
cabbrev bterm bo term
map <Leader>t :bterm ++close<CR>

" exit Terminal mode using Esc
tnoremap <Esc> <C-\><C-n>

"========[ FILE SETTINGS ]========

" autosave and autoload file views (to maintain folds)
" autocmd BufWinLeave ?* mkview
" autocmd BufWinEnter ?* silent loadview

filetype on         " try to detect the file type when opened,
filetype plugin on  " enable loading the plugin files,
filetype indent on  " and ident rules for specific file types

syntax enable       " switch syntax highlighting on


"========[ GOLANG SETTINGS ]========

" use tabs in Go files
autocmd FileType go setlocal noexpandtab


"========[ JENKINSFILE SETTINGS ]========

" my *.Jenkinsfile files are, by default, Groovy files
autocmd BufRead,BufNewFile *.Jenkinsfile setfiletype groovy


"========[ MARKDOWN SETTINGS ]========

" my *.md files are, by default, Markdown files with spellcheck
augroup markdownConfigs
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setfiletype markdown
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END


"========[ OBJC SETTINGS ]========

" my *.m files are, by default, Objective-C files
autocmd BufRead,BufNewFile *.m setfiletype objc


"========[ PERL SETTINGS ]========

" these files are, by default, Perl files
autocmd BufNewFile,BufRead *.t   set filetype=perl
autocmd BufNewFile,BufRead *.bml set filetype=perl tabstop=4 shiftwidth=4


"========[ SHELL SETTINGS ]========

" my *.zshrc files are, by default, zsh files
autocmd BufRead,BufNewFile *.zshrc setfiletype zsh


"========[ AIRLINE SETTINGS ]========

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


"========[ BETTER WHITESPACES SETTINGS ]========

let g:better_whitespace_enabled = 1


"========[ GUTTER SETTINGS ]========

let g:ale_sign_priority = 30
let g:gitgutter_sign_priority = 5


"========[ NERDTREE SETTINGS ]========

nmap <Leader>/ :NERDTreeToggle<CR>


"========[ TAGBAR SETTINGS ]========

nmap <Leader>. :TagbarToggle<CR>


"========[ CONTEXT SETTINGS ]========

" Redefined the default auto commands to update the context,
"  because 'CursorMoved' and 'WinScrolled' have poor performance.
let g:context_add_autocmds = 0
augroup context.vim
    autocmd!
    autocmd VimEnter     * ContextActivate
    autocmd BufAdd       * call context#update('BufAdd')
    autocmd BufEnter     * call context#update('BufEnter')
    " autocmd CursorMoved  * call context#update('CursorMoved')
    autocmd VimResized   * call context#update('VimResized')
    autocmd CursorHold   * call context#update('CursorHold')
    autocmd User GitGutter call context#update('GitGutter')
    autocmd OptionSet number,relativenumber,numberwidth,signcolumn,tabstop,list
                \          call context#update('OptionSet')

    " if exists('##WinScrolled')
    "    autocmd WinScrolled * call context#update('WinScrolled')
    " endif
augroup END

