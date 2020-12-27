" Return to last edit position when opening files (You want this!)
augroup ReturnToLastEditPosition
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  " https://neovim.io/doc/user/usr_05.html
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" Strip whitesapce and go back to last position
function! TrimWhitespace() abort
  if exists('b:no_strip_whitespace')
    return
  endif

  let l = line('.')
  let c = col('.')
  %s/\s\+$//e

  call cursor(l, c)
endfunction

augroup StripTrailingWhiteSpace
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

augroup BackupFileCallback
  autocmd!
  "Meaningful backup name, example: filename@2015-04-05.14:59
  autocmd BufwritePre * let &bex = substitute(expand('%:p:h'), '/', ':', 'g') . strftime('%F.%H:%M')
augroup END

augroup TerminalCallback
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * set signcolumn=no
augroup END

augroup HighlightCallback
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
