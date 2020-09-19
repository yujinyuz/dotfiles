" Return to last edit position when opening files (You want this!)
augroup ReturnToLastEditPosition
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
augroup EndAutocomplete
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup END

function! s:TrimWhitespace() abort
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfunction

augroup StripTrailingWhiteSpace
  autocmd!
  autocmd BufWritePre * call <SID>TrimWhitespace()
augroup END
