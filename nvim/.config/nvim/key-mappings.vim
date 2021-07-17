nnoremap <space>ff <cmd>lua require('telescope.builtin').find_files{ find_command = { 'rg', '--ignore', '--hidden', '--files' } }<cr>
nnoremap <space>fg <cmd>lua require('telescope.builtin').live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' } }<cr>
nnoremap <space>wf <cmd>lua require('telescope.builtin').find_files{ find_command = { 'rg', '--ignore', '--hidden', '--files' }, cwd = '~/wiki' }<cr>
nnoremap <space>wg <cmd>lua require('telescope.builtin').live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' }, cwd = '~/wiki' }<cr>
nnoremap <space>bb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <space>h <cmd>lua require('telescope.builtin').help_tags()<cr>

nmap <space>dc <Plug>VimspectorContinue
nmap <space>ds <Plug>VimspectorStop
nmap <space>dr <Plug>VimpectorRestart
nmap <space>dp <Plug>VimspectorPause
nmap <space>db <Plug>VimspectorToggleBreakpoint
nmap <space>dj <Plug>VimspectorStepOver
nmap <space>dl <Plug>VimspectorStepInto
nmap <space>dh <Plug>VimspectorStepOut
nmap <space>di <Plug>VimspectorBalloonEval
xmap <space>di <Plug>VimspectorBalloonEval

nnoremap <silent> <space>g :Git<cr>
" Use tab to toggle inline diff
autocmd FileType fugitive nmap <buffer> <tab> =

nnoremap <space>e :CocCommand explorer --width 60<CR>
nmap <space>dd :CocCommand java.debug.vimspector.start<CR>

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

" Navigate diagnostics
nmap <space>ck <Plug>(coc-diagnostic-prev)
nmap <space>cj <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <space>cd <Plug>(coc-definition)
nmap <space>ct <Plug>(coc-type-definition)
nmap <space>ci <Plug>(coc-implementation)
nmap <space>cr <Plug>(coc-references)

" Show documentation in preview window
nnoremap <space>cp :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <space>an <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<space>aap` for current paragraph
xmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <space>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <space>af  <Plug>(coc-fix-current)

" Mappings for CoCList
nnoremap <silent><nowait> <space>cx  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>fl  :<C-u>CocList lines<cr>

nnoremap <leader>t <Plug>VimwikiToggleListItem
vnoremap <leader>t <Plug>VimwikiToggleListItem

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch back and forth buffers
nnoremap <space>bh :bprevious<CR>
nnoremap <space>bl :bnext<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Switch tabs
nnoremap H gT
nnoremap L gt

" Make jj do esc in insert mode
inoremap jj <Esc>

" Make Ctrl-C do esc
map <C-c> <Esc>

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
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

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

" Insert date
nnoremap <leader>d "=strftime("%a, %m/%d/%y")<CR>P
inoremap <leader>d <C-R>=strftime("%a, %m/%d/%y")<CR>

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
