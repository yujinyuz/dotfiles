" Separate from .virmc so I can easily switch from one fuzzy finder

if !has_key(plugs, 'fzf.vim')
  finish
endif

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'round' } }
let $FZF_DEFAULT_OPTS = ''
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_tags_command = 'ctags -R'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'below split',
      \ 'ctrl-v': 'vsplit'
      \ }

" let g:fzf_preview_window = ''
let g:fzf_colors         = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Clear'],
      \ 'hl':      ['fg', 'String'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" Use CtrlP when Cmd-P is not available
nnoremap <silent> <C-p> :<C-u>Files<CR>
nnoremap <silent> <Space><Space> :<C-u>Files<CR>
" Buffers search
nnoremap <leader>b :<C-u>Buffers<CR>
" Search files relative to the current buffer
nnoremap <leader>ff :<C-u>Files %:p:h<CR>
" Tags search
nnoremap <leader>] :<C-u>Tags<CR>
" Global Search
nnoremap <leader>F :<C-u>RG<CR>

imap <C-x><C-k> <Plug>(fzf-complete-word)
imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
imap <C-x><C-l> <Plug>(fzf-complete-line)

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

autocmd! FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber signcolumn=no
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler number relativenumber signcolumn=yes
