" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffSaved setlocal nosplitright | vert new | set bt=nofile | r # | 0d_
                  \ | diffthis | wincmd p | diffthis | setlocal splitright

function! s:ToggleWrap() abort
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    setlocal colorcolumn=80,90,120
    silent! unmap <buffer> j
    silent! unmap <buffer> k
    silent! unmap <buffer> $
    silent! unmap <buffer> 0
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    setlocal colorcolumn=
    noremap <buffer> <silent> j gj
    noremap <buffer> <silent> k gk
    noremap <buffer> <silent> $ g$
    noremap <buffer> <silent> 0 g0
  endif
endfunction
command! ToggleWrap call <SID>ToggleWrap()

" Substitue selected text starting from cursor up to EOF
command! -nargs=* -complete=command ZZWrap let &scrolloff=999 | exec <q-args> | let &so=0

" Delete all buffers except current one
command! BufOnly silent! execute "%bd|e#|bd#"
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
