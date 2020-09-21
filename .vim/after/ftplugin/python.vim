if exists('b:my_python_ftplugin')
  finish
endif
let b:my_python_ftplugin = 1

setlocal tabstop=4
setlocal shiftwidth=4

let b:ale_linters = ['flake8']
let b:ale_fixers = ['autopep8', 'isort']
