"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if necessary
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" UI
Plug 'altercation/vim-colors-solarized'

Plug 'itchyny/lightline.vim'
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'cocstatus': 'coc#status',
  \ },
  \ }

Plug 'edkolev/tmuxline.vim'

" Fuzzy find files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nmap <silent> <Space>b :Buffers<cr>
nmap <silent> <Space>c :Commands<cr>
nmap <silent> <Space>a :BLine<cr>
nmap <silent> <Space>s :Lines<cr>
nmap <silent> <Space>r :Rg<cr>
nmap <silent> <Space>f :GFiles<cr>
nmap <silent> <Space>g :Files<cr>
nmap <silent> <Space>w :Wiki<cr>
" GFiles fallback to Files
" nnoremap <expr> <Space>f (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Wiki
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '
  \   . (len(<q-args>) > 0 ? <q-args> : '""') . ' ~/wiki/*.wiki', 1, fzf#vim#with_preview(), <bang>0)

" Remove fzf status line
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Insert or delete brackets, parens, quotes in pair
" Plug 'jiangmiao/auto-pairs'

" Change surroundings in pair
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Search inside files using ripgrep. This plugin provides an Ack command.
Plug 'wincent/ferret'

" Git
Plug 'tpope/vim-fugitive'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-prettier', 'coc-explorer', 'coc-emmet', 'coc-json', 'coc-pairs', 'coc-snippets']
nmap <space>e :CocCommand explorer --position=floating<CR>

" https://github.com/weirongxu/coc-explorer/wiki/Highlight
autocmd ColorScheme *
  \ hi CocExplorerNormalFloat guibg=#272B34

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Language support
Plug 'sheerun/vim-polyglot'
set conceallevel=2
let g:rustfmt_autosave = 1
filetype plugin on

" Snippets
" Plug 'honza/vim-snippets'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
set nocompatible
let g:vimwiki_list = [{
  \ 'path': '~/wiki/',
  \ 'path_html': '~/wiki_html',
  \ 'css_file': '~/wiki/_templates/main.css',
  \ 'template_path': '~/wiki/_templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html' }]

let g:auto_diary_index = 1
let g:vimwiki_table_mappings = 0

autocmd FileType vimwiki autocmd BufWritePost <buffer> silent Vimwiki2HTML

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=light
colorscheme solarized

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

set si "Smart indent

" Save yanked content to clipboard
set clipboard=unnamedplus

" Highlight current line
set cursorline

" Persistent undo, even if you close and reopen Vim.
set undofile

" Split the diff window in vertical
set diffopt+=vertical

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tab width for individual languages
autocmd Filetype solidity setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remove trailing white spaces on save
autocmd BufWritePre * %s/\s\+$//e

" Open Vim help in a vertical split window
autocmd FileType help wincmd L


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Switch tabs
nnoremap H gT
nnoremap L gt

" Make jj do esc
inoremap jj <Esc>

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Clear the search highlight
map <esc> :noh<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Visual mode pressing  # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Find and replace the current word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Clipboard overrides for system-clipboard integration and SSH-TMUX-Forwarding
" copy the current text selection to the system clipboard
if has('gui_running') || has('nvim') && exists('$DISPLAY')
  noremap <Leader>y "+y
else
  " copy to attached terminal using the yank(1) script:
  " https://github.com/sunaku/home/blob/master/bin/yank
  noremap <silent> <Leader>y y:call system('yank > /dev/tty', @0)<Return>
endif

" Replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
