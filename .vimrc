"                 _  _
"                (_)(_)
"   _   _  _   _  _  _  _ __   _   _  _   _  ____
"  | | | || | | || || || '_ \ | | | || | | ||_  /
"  | |_| || |_| || || || | | || |_| || |_| | / /
"   \__, | \__,_|| ||_||_| |_| \__, | \__,_|/___|
"    __/ |      _/ |            __/ |
"   |___/      |__/            |___/
"
"   Author: yujinyuz
"   GitHub: https://github.com/yujinyuz
"   Repository URL: https://github.com/yujinyuz/dotfiles
"   Desc: Collection of dotfiles gathered across different dotfiles repos

" General {{{

" Shift 4 spaces when pressing tab
set tabstop=4
" Shift 4 spaces when pressing < or >
set shiftwidth=4

" Use spaces instead of tabs
set expandtab
" Make search case insenstive
set ignorecase
" Unless it contains atleast one capital letter
set smartcase

" Turn on relative numbers
set relativenumber
" Show current line number
set number

" Visual autocomplete for command menu triggered when
" pressing tab while in the execute command mode
set wildmenu
set wildcharm=<C-z>

" Redraw only when needed
set lazyredraw

" Hide buffer when switching to other files
set hidden

" Prefer bash for shell-related tasks
set shell=/bin/bash

" Disable annoying swap files
set noswapfile

" No backups
set nobackup nowritebackup

" Use system clipboard
set clipboard+=unnamedplus

" Search relative to current file and directory
set path=.,**

" Split right by default
set splitright

" Always show tabs
set showtabline=2

" Symbols used for displaying whitespace characters
set listchars=tab:→\ ,space:·,nbsp:␣,trail:·,precedes:«,extends:»

" Disable soft wrapping
set nowrap

" Include tags relative to current file and directory
set tags^=.git/tags

" Show highlight when doing :%s/foo/bar
set inccommand=split

" Enable mouse coz why not?
set mouse=nicr

" Use rg instead of grep.
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
end

" Enable undo directory
set undofile
set undodir=~/.vim/undodir

" Disable intro message
set shortmess+=I
" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" Change leader key
let mapleader = ' '

" Neovim Python Provider
let g:loaded_python_provider = 0
let g:python3_host_prog = $PYTHON_3_HOST_PROG
" End General }}}

" Plugins {{{
" Automatically install plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" File management
" Better file tree alternative to NERDTree
Plug 'lambdalisue/fern.vim'
" Fuzzy search for files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax / Colors
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'

" IDE stuffs
" Make vim intelligent like VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
" Go development
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}
" Useful for generating tagbar
Plug 'liuchengxu/vista.vim'
" Mostly for linting
Plug 'dense-analysis/ale'
" Automatically close html tags
Plug 'alvan/vim-closetag'
" Awesome status line
Plug 'vim-airline/vim-airline'
" For .editorconfig files
Plug 'editorconfig/editorconfig-vim'
" Useful for showing what can be undone!
Plug 'mbbill/undotree'
" Useful with set autoread enabled
Plug 'tmux-plugins/vim-tmux-focus-events'
" Automatically generate tags file for us
Plug 'ludovicchabant/vim-gutentags'
" Syntax highlighting
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'

" Holiness
" Word manipulations
Plug 'tpope/vim-surround'
" For commenting out sutffs
Plug 'tpope/vim-commentary'
" Awesome git interface for in vim
Plug 'tpope/vim-fugitive'
" Automatically end things for us specially in rails
Plug 'tpope/vim-endwise'
" Add extra functionality to the dot operator
Plug 'tpope/vim-repeat'
" Automatically save sessions for us
Plug 'tpope/vim-obsession'
" Add some helpful mappings. See docs
Plug 'tpope/vim-unimpaired'
" Dispatch an external command
Plug 'tpope/vim-dispatch'
" Enables :GBrowse when using vim-fugitive
Plug 'tpope/vim-rhubarb'

" Misc
" Enhances buffer search
Plug 'junegunn/vim-slash'
" More snippets!
Plug 'honza/vim-snippets'
" Only use this for [ydc]ae
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
" Wakatime vim plugin
Plug 'wakatime/vim-wakatime'
call plug#end()
" End Plugins}}}

" Native Key Mappings {{{
" Leader
" w = write
nmap <leader>w :w!<CR>
" qa = quit all
nmap <leader>qa :qa!<CR>
" qq = quit current
nmap <leader>qq :q!<CR>

" Blackhole deletes
nnoremap <leader>d "_d

" source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Clear search highlight
nnoremap <silent> <leader>l :noh<CR>

" Find and Replace highlighted line
nnoremap <leader>cu "hy:%s/<C-r>h//gc<left><left><left>

" Find and replace highlighted word with confirmation until EOF
" cu =  change under
noremap <leader>cu "sy:ZZWrap .,$s/<C-r>s//gc<Left><Left><Left>

" Faster project-based editing
" nnoremap ,e :e **/*<C-z><S-Tab>
" Make sure set wildcharm=<C-z> exists in config
nnoremap <leader>e :edit <C-z><S-Tab>
nnoremap <leader>E :edit **/*<C-z><S-Tab>

" Copy current filepath to clipboard
nnoremap <leader>cp :<C-u>let @+ = expand('%:p')<CR>

" Map jk to Escape because it's too far away
inoremap jk <Esc>

" Make Y work like other upcase commands
nnoremap Y y$

" Direct changes into the black hole register.
nnoremap c "_c
nnoremap C "_C

" Copy/paste and move cursor to end of last operated text or end of putted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Stay in visual mode when indenting. You will never have to run
" gv after performing an indentation
vnoremap < <gv
vnoremap > >gv

" <BS> = buffer switch
nnoremap <BS> <C-^>
" gb = go buffer
nnoremap gb :ls<CR>:b

" Command-line like forward/reverse search
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>


" Use Alt-jk for moving lines
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Disable arrow movements. Resize splits panes instead
if get(g:, 'elite_mode')
  nnoremap <Up> :resize +2<CR>
  nnoremap <Down> :resize -2<CR>
  nnoremap <Left> :vertical resize +2<CR>
  nnoremap <Right> :vertical resize -2<CR>
endif

" Togglewrap
noremap \\ :ToggleWrap<CR>

" Disable annoying Ex mode
map Q gq

" Visually select pasted or yanked text
nnoremap gV `[v`]

" Access file name data
" fp = filepath
" fn = filename
cnoremap \fp <C-R>=expand('%:p:h')<CR>
inoremap \fp <C-R>=expand('%:p:h')<CR>
cnoremap \fn <C-R>=expand('%:t:r')<CR>
inoremap \fn <C-R>=expand('%:t:r')<CR>

" Date and datetime formatted
cnoremap \dt <C-R>=strftime('%b %d, %Y')<CR>
inoremap \dt <C-R>=strftime('%b %d, %Y')<CR>
cnoremap \dT <C-R>=strftime('%m-%d-%Y')<CR>

cnoremap \tn <C-R>=strftime('%Y-%m-%d %a %I:%M %p')<CR>
inoremap \tn <C-R>=strftime('%Y-%m-%d %a %I:%M %p')<CR>

" For faster navigation
nnoremap <leader>j 10j
nnoremap <leader>k 10k
nnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>

" For easier splitting of files
map s <NOP>
nmap ss :split<CR><C-w>w
nmap sv :vsplit<CR><C-w>w

" For navigating splits
nnoremap <C-l> :<C-u>echoerr('Use sl')<CR>
nnoremap <C-h> :<C-u>echoerr('Use sh')<CR>
nnoremap <C-k> :<C-u>echoerr('Use sk')<CR>
nnoremap <C-j> :<C-u>echoerr('Use sj')<CR>

nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sk <C-w>k
nnoremap sj <C-w>j

" Readline-like mappings
" - Ctrl-a - go to the start of line
" - Ctrl-e - go to the end of the line
" - Alt-b  - back a word
" - Alt-f  - forward a word
" - Alt-BS - delete backward word
" - Alt-d  - delete forward word
inoremap <C-a>  <C-o>^
inoremap <C-e>  <C-o>$
inoremap <A-b>  <C-Left>
inoremap <A-f>  <C-Right>
inoremap <A-BS> <C-w>
inoremap <A-d>  <C-o>dw
" As above but for command mode.
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>
cnoremap <A-b>  <C-Left>
cnoremap <A-f>  <C-Right>
cnoremap <A-BS> <C-w>
cnoremap <A-d>  <C-Right><C-w>

" Jump to first tag if only one exists
" else, let us choose which tag to jump to
nnoremap <C-]> g<C-]>:echo expand('%:p')<CR>

" Write file as sudo
cnoremap w!! w !sudo tee % >/dev/null
" End Native }}}

" Plugins custom settings {{{

" ale {{{
let g:ale_fixers = {
\ '*': ['remove_trailing_lines'],
\ }
let g:ale_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 0
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'

" next/previous warnings or errors
nmap ]w <Plug>(ale_next_wrap)
nmap [w <Plug>(ale_previous_wrap)
" }}}

" closetag.vim {{{
let g:closetag_filenames = '*.html,*.js,*.erb'
let g:closetag_emptyTags_caseSensitive = 1
" }}}

" endwise {{{
let g:endwise_no_mappings = 1
" }}}

" editorconfig-vim {{{
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
" }}}

" statusline {{{
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }
" }}}

" fzf.vim {{{
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'round' } }
let g:fzf_tags_command = 'ctags -R'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'below split',
  \ 'ctrl-v': 'vsplit'
  \ }
" Use CtrlP when Cmd-P is not available
nnoremap <silent> <C-p> :<C-u>Files<CR>
nnoremap <silent> <Space><Space> :<C-u>Files<CR>
" Buffers search
nnoremap <leader>b :<C-u>Buffers<CR>
" Search files relative to the current buffer
nnoremap <leader>ff :<C-u>Files %:p:h<CR>
" Tags search
nnoremap <leader>] :<C-u>Tags<CR>
" Global Search
nnoremap <leader>F :<C-u>RG<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}

" vim-fugitive {{{
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>h :Git difftool<CR>
" }}}

" File Explorer {{{
let g:fern#disable_default_mappings = 1
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#marked_symbol    = '●'
let g:fern#renderer#default#root_symbol      = '~ '
let g:fern#renderer#default#unmarked_symbol  = ''
noremap <silent> <C-n> :<C-u>Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>sf :<C-u>Fern . -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> <Leader>. :<C-u>Fern %:h -drawer -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)j
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> m <Plug>(fern-action-mark-toggle)j
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
" }}}

" netrw {{{
let g:loaded_netrwPlugin = 1 " Disable netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" }}}

" mbbill/undotree {{{
let g:undotree_HighlightChangedWithSign = 0
let g:undotree_WindowLayout = 4
let g:undotree_SetFocusWhenToggle = 1
nnoremap <leader>u :UndotreeToggle<CR>
" }}}

" vim-closetag {{{
let g:closetag_filenames = '*.html,*.hbs'
let g:closetag_emptyTags_caseSensitive = 1
" }}}

" vim-go {{{
let g:go_def_mapping_enabled = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = 'goimports'
" }}}

" vim-highlightedyank {{{
let g:highlightedyank_highlight_duration = 250
" }}}

" vim-polyglot {{{
let g:mkdx#settings = { 'highlight': { 'enable': 1 },
                      \ 'enter': { 'shift': 1 },
                      \ 'links': { 'external': { 'enable': 1 } },
                      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                      \ }
" }}}

" vim-slash {{{
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <Plug>(slash-after) 'zz'.slash#blink(2, 50)
endif
" }}}

" vista.vim {{{
nmap \b :Vista!!<CR>
nnoremap <leader>v :Vista finder<CR>
" }}}

" End Plugins Custom Settings }}}

" Colors {{{
syntax on

if has('termguicolors')
  set termguicolors
endif
set t_Co=256
colorscheme onedark
" Make background transparent
hi Normal guibg=NONE ctermbg=NONE
" End Colors }}}

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vim:filetype=vim sw=2 foldmethod=marker tw=78 expandtab
