" TODO: Port this file to Lua. Though I'm not sure how I'm gonna do the other shits
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
  autocmd User TelescopePreviewerLoaded setlocal wrap
  autocmd FileType TelescopePrompt iunmap <C-X><C-A>
  autocmd FileType markdown nmap <buffer> <CR> <Plug>WorkbenchToggleCheckbox
  autocmd FileType gitcommit setlocal spell
  autocmd BufWinEnter NvimTree setlocal cursorline nowrap signcolumn=no
  autocmd BufWritePost plugins.lua PackerCompile
augroup END
