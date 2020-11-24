if !has_key(plugs, 'coc.nvim')
  finish
endif

if exists('g:custom_coc_config_loaded')
  finish
end

let g:custom_coc_config_loaded = 1
let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-solargraph',
  \ 'coc-vimlsp',
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

if has_key(plugs, 'vim-endwise')
  " Make coc.nvim compatible with endwise
  " See: https://github.com/tpope/vim-endwise/issues/22#issuecomment-554685904
  inoremap <silent><expr> <Plug>CustomCocCR complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
  imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd
else
  " Use default recommended settings from coc.nvim docs
  inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<C-R>=coc#on_enter()\<CR>"
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
nmap <silent> <leader>ca <Plug>(coc-codeaction)
xmap <silent> <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>cs :echohl String \| echo(coc#status()) \| echohl None<CR>

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

augroup CocCallbacks
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')
  " https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup end

" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> \a :<C-u>CocFzfList diagnostics<cr>
" Manage extensions
nnoremap <silent> \e :<C-u>CocFzfList extensions<cr>
" Show commands
nnoremap <silent> \c :<C-u>CocFzfList commands<cr>
" Find symbol of current document
nnoremap <silent> \o :<C-u>CocFzfList outline<cr>
" Search workspace symbols
nnoremap <silent> \s :<C-u>CocFzfList symbols<cr>
" Do default action for next item.
nnoremap <silent> \j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> \k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> \p :<C-u>CocListResume<CR>
