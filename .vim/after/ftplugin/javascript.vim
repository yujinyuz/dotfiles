if exists('b:my_javascript_ftplugin')
  finish
endif
let b:my_javascript_ftplugin = 1

let b:ale_linters = ['eslint']
let b:ale_fixers = ['eslint']

let b:coc_pairs_disabled = ['<']
