set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set autoindent
set ignorecase
set smartcase
set relativenumber
set number
set title
set hidden
set noswapfile
set path=.,**
set splitright
set showtabline=2
set nowrap
set mouse=nicr
set shortmess+=aIc
set formatoptions-=ato2
set formatoptions+=cqrnj
set completeopt=menuone,noselect,noinsert
set pumheight=15
set signcolumn=yes
set updatetime=250
set scrolloff=8
set sidescrolloff=15
set noshowmode
set wildmenu
set wildcharm=<C-z>
set wildmode=longest,full
set wildoptions=pum
set foldlevelstart=99
set foldmethod=indent
set termguicolors
set lazyredraw
set breakindent
set showbreak='↳'
set colorcolumn=80,120
set incsearch

let mapleader = " "

" set background=light
syntax on
" industry darkblue torte
colorscheme slate


hi! Normal guibg=NONE ctermbg=NONE
hi! EndOfBuffer guibg=NONE ctermbg=NONE

let g:netrw_winsize = 15
let g:netrw_banner = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_liststyle = 3
let g:netrw_altv = 1
" use the previous window to open file
let g:netrw_browse_split = 4
hi! link netrwMarkFile Search

nnoremap <C-n> :Lexplore<CR>

" Open directory of current file
nnoremap <leader>. :Sexplore %:p:h<CR>
nnoremap <leader>/ :Sexplore<CR>

autocmd FileType netrw nnoremap <buffer> l <Plug>NetrwLocalBrowseCheck
" autocmd FileType netrw nmap <buffer>  l o
autocmd FileType netrw nnoremap <buffer> - <Plug>NetrwBrowseUpDir
autocmd FileType netrw nnoremap <buffer> h <Plug>NetrwBrowseUpDir
autocmd FileType netrw nmap <buffer> I gh

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()


nnoremap <C-p> :e **/

nnoremap <leader>fn :e %:h<C-z>

nnoremap <leader>w :update<CR>
nnoremap <leader>qq :q!<CR>
nnoremap <leader>qa :qa!<CR>
nnoremap Y y$
nnoremap <BS> <C-^>

nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W

nnoremap Q "_

vnoremap < <gv
vnoremap > >gv

cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>

" Toggles
nnoremap <silent> yow :set wrap!<CR>
