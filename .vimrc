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

" Whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)

" Searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Turn on relative numbers
set relativenumber

" Show current line number
set number

" How many tenths of a second to blink when matching brakcets
set matchtime=2

" Visual autocomplete for command menu
" triggered when pressing tab while in the
" execute command mode `:`
set wildmenu

" set wildmode=list:longest,list:full
" Disabled wildignore since it conflicts with tags
" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Redraw only when needed
set lazyredraw

" Hide buffer
set hidden

" Fix paste bug [200~ when remapping jk to escape
set t_BE=

" Always show signcolumns
set signcolumn=yes

" Prefer bash for shell-related tasks
set shell=/bin/bash

" Disable annoying swap files
set noswapfile

" No backups
set nobackup nowritebackup

" Use system clipboard
set clipboard+=unnamedplus

" Disable neovim from setting cursor style
" set guicursor=

" Only need 1 line for cmd
set cmdheight=1

" Let vim set the title
set title

" Search relative to current file and directory
set path=.,**

" Split right by default
set splitright

" Split below by default
" set splitbelow

" Hide the -- INSERT --
" comment this out when you aren't using lightline.vim
" set noshowmode

" Alwayts show tabs
set showtabline=2

" Show whitespaces
" set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:·,precedes:«,extends:»

" Show line column
set colorcolumn=80,90,120

" Show 3 more lines below/above when scrolling
set scrolloff=3

" Show indicator when line is wrapped
let &showbreak='↳ '
set conceallevel=3

" Disable soft wrapping
set nowrap

" ID Tags relative to current file and directory
set tags^=.git/tags

" Show highlight when doing :%s/foo/bar
set inccommand=split

" Enable mouse coz why not?
set mouse=nicr

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=512

" Don't wait too long for key sequences
set timeoutlen=500

" Avoid annoying mode switch lag
set ttimeoutlen=50

" Use rg instead of grep.
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" Enable undo directory
set undodir=~/.vim/undodir
set undofile

" Disable intro message
set shortmess+=I

set omnifunc+=ale#completion#OmniFunc

" Change leader key
let mapleader = ' '

" Enable elite mode. No arrows!!
let g:elite_mode = 1

" Disable python2 provider
let g:loaded_python_provider = 0
let g:python3_host_prog = $PYTHON_3_HOST_PROG

" Disable highlighting matched parenthesis
let g:loaded_matchparen = 1

" NeoVim Enabled Defaults {{{
" Just uncomment the lines with `set` to when not using neovim
" Autoread file when there are changes
" set autoread

" Helps force plugins to load correctly when it is turned back on
" filetype off

" Load file type plugins + indentation
" filetype plugin indent on

" backspace through everything in insert mode
" set backspace=indent,eol,start


" Disable annoying bell sound
" set belloff=all
" set visualbell

" Choose no compatibility with legacy vi
" set nocompatible

" Use utf-8 file encoding
" set encoding=utf-8

" Display incomplete commands
" set showcmd

" Keep info in memory to speed things up
" set history=10000

" Highlight matches
" set hlsearch

" Incremental searching
" set incsearch

" Enable ruler
" set ruler

"" End NeoVim Enabled Defaults }}}

" End General }}}

" Plugins {{{
" Automatically install plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'lambdalisue/fern.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'vn-ki/coc-clap'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rhubarb'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}
Plug 'alvan/vim-closetag'
Plug 'vim-airline/vim-airline'
Plug 'fcpg/vim-waikiki'
Plug 'honza/vim-snippets'
Plug 'liuchengxu/vista.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'mbbill/undotree'
Plug 'dense-analysis/ale'
Plug 'wakatime/vim-wakatime'
Plug 'SidOfc/mkdx'
Plug 'machakann/vim-highlightedyank'
Plug 'editorconfig/editorconfig-vim'
call plug#end()
" End Plugins}}}

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

" Native Key Mappings {{{

" Writing and quitting
" w = write
" qa = quit all
" qq = quit current
nmap <leader>w :w!<CR>
nnoremap <leader>qa :qa!<CR>
nmap <leader>qq :q!<CR>

" Editing vimrc
" ev = edit vimrc
" sv = source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Map jk to Escape because it's too far away
inoremap jk <Esc>

" Make Y work like other upcase commands
nnoremap Y y$

" Copy/paste and move cursor to end of last operated text or end of putted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Stay in visual mode when indenting. You will never have to run
" gv after performing an indentation
vnoremap < <gv
vnoremap > >gv


" Blackhole deletes
nnoremap <leader>d "_d

" Buffers
" <BS> = buffer switch
" gb = go buffer
nnoremap <BS> :buffer#<CR>:echo bufnr('%') . ': ' . expand('%:p')<CR>
nnoremap gb :ls<CR>:b

" Tab management
map \tn :tabnew<CR>
map \to :tabonly<CR>
map \tc :tabclose<CR>
map \tm :tabmove<CR>

" Command-line like forward/reverse search
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Clear search highlight
nnoremap <silent> <leader>l :noh<CR>

" Use Alt-jk for moving lines
" Note: iTerm2 > Profiles > Keys > Left Option > Esc+
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

" Open definition in new tab
map <C-\> :tab split<CR>:exec('tag '.expand('<cword>'))<CR>

" Find and Replace highlighted line
nnoremap <leader>cu "hy:%s/<C-r>h//gc<left><left><left>

" Find and replace highlighted word with confirmation until EOF
" cu =  change under
noremap <leader>cu "sy:ZZWrap .,$s/<C-r>s//gc<Left><Left><Left>

" Togglewrap
noremap \\ :ToggleWrap<CR>

" Disable annoying Ex mode
nnoremap Q <NOP>

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
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sk <C-w>k
nnoremap sj <C-w>j

" Jump to first tag if only one exists
" else, let us choose which tag to jump to
nnoremap <C-]> g<C-]>:echo expand('%:p')<CR>

" bind K to grep word under cursor
nnoremap K :Rg <C-R><C-W><CR>

" Write file as sudo
cnoremap w!! w !sudo tee % >/dev/null
" End Native }}}

" Plugins custom settings {{{

" ale {{{
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '⚠'
let g:ale_on_enter = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'

" https://github.com/dense-analysis/ale/issues/249
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" hi link ALEErrorSign    Error
" hi link ALEWarningSign  Warning
" highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=NONE
" highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=NONE

" next/previous warnings or errors
nmap ]w <Plug>(ale_next_wrap)
nmap [w <Plug>(ale_previous_wrap)
" }}}

" closetag.vim {{{
let g:closetag_filenames = '*.html,*.js,*.erb'
let g:closetag_emptyTags_caseSensitive = 1
" }}}

" coc.vim {{{
let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-emmet',
  \ 'coc-json',
  \ 'coc-sql',
  \ 'coc-tsserver',
  \ 'coc-pairs',
  \ 'coc-yaml',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-cssmodules',
  \ 'coc-snippets'
  \ ]
" 'coc-eslint'
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
let g:fzf_tags_command = 'ctags -R'
let g:fzf_preview_window = 'down:1'
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'below split',
  \ 'ctrl-v': 'vsplit'
  \ }

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
noremap <silent> <Leader>nf :<C-u>Fern . -drawer -reveal=% -width=35<CR><C-w>=
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
" let g:loaded_netrwPlugin = 1 " Disable netrw
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

" vim-clap {{{
let g:clap_theme = 'material_design_dark'
let g:clap_insert_mode_only = v:true
let g:clap_layout = { 'relative': 'editor' }
" Use CtrlP when Cmd-P is not available
nnoremap <silent> <C-p> :<C-u>Clap files<CR>
nnoremap <Space><Space> :<C-u>Clap files<CR>
" Buffers search
nnoremap <leader>b :<C-u>Clap buffers<CR>
" Search files relative to the current buffer
nnoremap <leader>ff :<C-u>Clap filer %:p:h<CR>

" Tags search
nnoremap <leader>t :<C-u>Clap proj_tags<CR>
nnoremap <leader>T :<C-u>Clap tags<CR>

" Global search
nnoremap <leader>F :<C-u>Clap grep<CR>
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
let g:polyglot_disabled = ['markdown']
let g:mkdx#settings = { 'highlight': { 'enable': 1 },
                      \ 'enter': { 'shift': 1 },
                      \ 'links': { 'external': { 'enable': 1 } },
                      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                      \ }
" }}}

" vim-slash {{{
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)
endif
" }}}

" vim-waikiki {{{
let g:waikiki_roots = ['~/vimwiki']
let g:waikiki_default_maps = 1
" }}}

" vista.vim {{{
nmap \b :Vista!!<CR>
nnoremap <leader>v :Vista finder<CR>
" }}}

" End Plugins Custom Settings }}}

" coc.nvim settings from documentation {{{
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make CoC and endwise compatible
" https://github.com/tpope/vim-endwise/issues/22#issuecomment-554685904
" inoremap <expr> <Plug>CustomCocCR complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
" imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>\<C-R>=coc#on_enter()\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<C-R>=coc#on_enter()\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" would've been better to remap `coc-definition` and others
" to start with `g` but I changed it to `<leader>c[char]` so that
" it would remind me that it's from coc.nvim.
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>cn <Plug>(coc-rename)
nmap <silent> <leader>ck :call <SID>show_documentation()<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand-jump)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for format selected region
xmap <leader>cf <Plug>(coc-format-selected)
nmap <leader>cf <Plug>(coc-format-selected)

augroup CocGroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> \a :<C-u>Clap coc_diagnostics<cr>
" Manage extensions
nnoremap <silent> \e :<C-u>Clap coc_extensions<cr>
" Show commands
nnoremap <silent> \c :<C-u>Clap coc_commands<cr>
" Find symbol of current document
nnoremap <silent> \o :<C-u>Clap coc_outline<cr>
" Search workspace symbols
nnoremap <silent> \s :<C-u>Clap coc_symbols<cr>
" Do default action for next item.
nnoremap <silent> \j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> \k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> \p :<C-u>CocListResume<CR>
" End coc.nvim settings }}}

if filereadable(expand('$HOME/.vimrc.local'))
  source $HOME/.vimrc.local
endif
" vim:filetype=vim sw=2 foldmethod=marker tw=78 expandtab
