-- Here resides some config files that require minimal config
local helpers = require('jyz.lib.nvim_helpers')
local set_keymap = helpers.set_keymap


-- vim-polyglot
vim.g.polyglot_disabled = {
  'markdown',
  'python.plugin',
  'html.plugin',
  'javascript.plugin',
}

-- ale
vim.g.ale_linters_explicit = 1
vim.g.ale_fixers = {
  python = {'autopep8', 'isort'}
}
vim.g.ale_sign_error = '✘'
vim.g.ale_sign_warning = '⚠'

-- vim-fugitive
set_keymap('n', '<leader>gs', helpers.cmd_map('Git'), {silent = true})

-- vim-dirvish
set_keymap('n', '<leader>.', helpers.cmd_map('Dirvish %:p:h'), {silent = true})

-- Disable netrw
vim.g.loaded_netrwPlugin = 1

-- undotree
vim.g.undotree_HighlightChangedWithSign = 0
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SetFocusWhenToggle = 1
set_keymap('n', '<leader>u', helpers.cmd_map('UndoTreeToggle'), {silent = true})

-- vim-closetag
vim.g.closetag_filename = '*.html,*.js,*.erb,*.hbs'
vim.g.closetag_emptyTags_caseSensitive = 1

-- vim-go
vim.g.go_def_mapping_enabled = 0
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_structs = 1
vim.g.go_fmt_command = 'goimports'

-- vista.vim
set_keymap('n', [[\b]], helpers.cmd_map('Vista!!'), {silent = true})
