syntax match Comment +\/\/.\+$+

" json commands
command! FormatJson silent! execute "%!jq '.' --indent 4"
