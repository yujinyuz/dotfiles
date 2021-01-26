-- Here resides some config files that require minimal config
local helpers = require('jyz.lib.nvim_helpers')

-- TODO: Maybe only have a single `create_mappings`??

-- nvim-compe
helpers.create_mappings {
  i = {
    {lhs = '<C-Space>', rhs = [[compe#complete()]], opts = {noremap = true, silent = true, expr = true}},
    {lhs = '<CR>', rhs = [[compe#confirm('<CR>')]], opts = {noremap = true, silent = true, expr = true}},
    {lhs = '<C-e>', rhs = [[compe#close()]], opts = {noremap = true, silent = true, expr = true}},
  }
}

-- vim-fugitive
helpers.create_mappings {
  n = {
    {lhs = '<leader>gs', rhs = helpers.cmd_map('Git'), opts = {silent = true, noremap = true}},
  }
}

-- vim-dirvish
helpers.create_mappings {
  n = {
    {lhs = '<leader>.', rhs = helpers.cmd_map('Dirvish %:p:h'), opts = {silent = true, noremap = true}},
  }
}

-- Disable netrw
vim.g.loaded_netrwPlugin = 1

-- undotree
vim.g.undotree_HighlightChangedWithSign = 0
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SetFocusWhenToggle = 1
helpers.create_mappings {
  n = {
    {lhs = '<leader>u', rhs = helpers.cmd_map('UndotreeToggle'), opts = {silent = true, noremap = true}},
  }
}

-- vim-go
vim.g.go_def_mapping_enabled = 0
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_structs = 1
vim.g.go_fmt_command = 'goimports'

-- vista.vim
helpers.create_mappings {
  n = {
    {lhs = [[\b]], rhs = helpers.cmd_map('Vista!!'), {silent = true}},
  }
}
vim.g.dap_virtual_text = true
