if !has_key(plugs, 'coc.nvim')
  finish
endif

nmap ]w <Plug>(ale_next_wrap)
nmap [w <Plug>(ale_previous_wrap)

nmap <leader>af <Plug>(ale_fix)
nmap <leader>at <Plug>(ale_toggle)

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
" highlight ALEErrorSign ctermbg=NONE ctermfg=red
" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
