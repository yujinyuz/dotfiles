if exists('b:custom_ftplugin')
  finish
endif
let b:custom_ftplugin = 1

syntax match Comment +\/\/.\+$+

" json commands
command! FormatJson silent! execute "%!jq"
