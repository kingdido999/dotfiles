let g:vimwiki_list = [{
  \ 'path': '~/wiki/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md' },{
  \ 'path': '~/journal/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md' }]

let g:vimwiki_global_ext = 0
let g:auto_diary_index = 1

set completeopt=menu,menuone,noselect

set termguicolors
syntax enable
set background=light
colorscheme solarized

set laststatus=3

" Use bash shell to ensure fast git operations
set shell=/bin/bash

" Show line numbers
set number

" Sets how many lines of history VIM has to remember
set history=500

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Shows the effects of a command incrementally, as you type
set inccommand=split

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

" Always show the status line
set laststatus=2

" -- INSERT -- is unnecessary anymore because the mode information is displayed in the status line.
set noshowmode

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

set shiftwidth=2
set tabstop=2

" Line break on 500 characters
set lbr
set tw=500

set smartindent

" Save yanked content to clipboard
set clipboard=unnamedplus

" Highlight current line
set cursorline

" Persistent undo, even if you close and reopen Vim.
set undofile

" Split the diff window in vertical
set diffopt+=vertical

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" Recently vim can merge signcolumn and number column into one
set signcolumn=number

" Language support
set conceallevel=2
filetype plugin on

set nocompatible

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remove trailing white spaces on save
autocmd BufWritePre * %s/\s\+$//e

" Open Vim help in a vertical split window
autocmd FileType help wincmd L

" Use a project-local version of Prettier
let g:neoformat_try_node_exe = 1

" Run formatter on save
augroup fmt
  autocmd!
  autocmd BufWritePre *.js, *.ts undojoin | Neoformat
augroup END
