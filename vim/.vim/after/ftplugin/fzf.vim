if exists('*nvim_open_win')
  finish
endif

" set nonumber, norelativenumber for neovim
" line number is not neccessary for fuzzy finder
" setl laststatus=0 noshowmode noruler nonumber norelativenumber
" Clear the message
echo "\r"

augroup FZFFiletype
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
