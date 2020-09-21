if exists('b:my_vim_ftplugin')
  finish
endif
let b:my_vim_ftplugin = 1

setlocal shiftwidth=2
setlocal textwidth=78
setlocal expandtab
setlocal foldmethod=marker

let b:coc_pairs_disabled = ['<', '"']
