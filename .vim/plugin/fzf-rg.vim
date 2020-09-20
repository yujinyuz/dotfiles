" commands for fzf + ripgrep integration

" Rg with preview window
" Just search for text inside files and not file names
" We already have :Files for searching files anyway!
" https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
let g:rg_command = 'rg --column --line-number --no-heading --color=always --smart-case '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   g:rg_command.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --prompt "AllFiles> "'}), <bang>0)

command! -bang -nargs=* RgWeb
  \ call fzf#vim#grep(
  \   g:rg_command.'--type-add "web:*.{html,js,jsx,ts,css,sass,scss}" -tweb '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --prompt "WebOnly> "'}), <bang>0)

function! RipgrepFzf(query, fullscreen) abort
  let command_fmt = g:rg_command.'%s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
