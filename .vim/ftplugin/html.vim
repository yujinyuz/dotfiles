if exists('b:custom_ftplugin')
  finish
endif
let b:custom_ftplugin = 1

setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

let b:coc_pairs_disabled = ['<']
