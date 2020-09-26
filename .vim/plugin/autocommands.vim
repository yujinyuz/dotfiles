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


" Trim Whitesapce and go back to last position
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
