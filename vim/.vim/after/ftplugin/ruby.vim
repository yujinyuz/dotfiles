setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

let b:ale_linters = ['standardrb', 'rubocop']
let b:ale_fixers = ['standardrb']

nmap <buffer> <leader>gc :Econtroller<CR>
nmap <buffer> <leader>gt :Eview<CR>
nmap <buffer> <leader>gm :Emodel<CR>
