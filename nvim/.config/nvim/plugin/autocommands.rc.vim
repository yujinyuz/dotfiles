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

augroup StripTrailingWhiteSpace
  " Strip trailing whitespace and go back to last cursor position
  autocmd!
  autocmd! BufWritePre *
    \ if &ft !~# 'commit'
    \ |   let l = line('.')
    \ |   let c = col('.')
    \ |   %s/\s\+$//e
    \ |   call cursor(l, c)
    \ | endif
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

augroup NumberToggle
  autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END

augroup T
  autocmd!
augroup END


" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

" Underline the offending code
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

