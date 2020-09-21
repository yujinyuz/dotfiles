if exists('b:my_html_ftplugin')
  finish
endif
let b:my_html_ftplugin = 1

setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

let b:coc_pairs_disabled = ['<']
