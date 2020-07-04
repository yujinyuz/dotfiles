if exists('b:custom_ftplugin')
  finish
endif
let b:custom_ftplugin = 1

setlocal shiftwidth=2
setlocal textwidth=78
setlocal expandtab
setlocal foldmethod=marker

let b:coc_pairs_disabled = ['<', '"']
