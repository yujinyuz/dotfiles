if exists('b:custom_ftplugin')
  finish
endif
let b:custom_ftplugin = 1

let b:ale_linters = ['eslint']
let b:ale_fixers = ['eslint']

let b:coc_pairs_disabled = ['<']
