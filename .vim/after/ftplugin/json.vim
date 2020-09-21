if exists('b:my_json_ftplugin')
  finish
endif
let b:my_json_ftplugin = 1

syntax match Comment +\/\/.\+$+

" json commands
command! FormatJson silent! execute "%!jq"
