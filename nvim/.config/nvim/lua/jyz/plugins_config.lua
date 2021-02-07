-- Here resides some config files that require minimal config
local helpers = require('jyz.lib.nvim_helpers')

-- TODO: Maybe only have a single `create_mappings`??

-- vim-closetag
vim.g.closetag_filename = '*.html,*.js,*.erb,*.hbs'
vim.g.closetag_emptyTags_caseSensitive = 1

-- nvim-compe
helpers.create_mappings {
  i = {
    {lhs = '<Tab>', rhs = [[pumvisible() ? "\<C-n>": "\<Tab>"]], opts = {noremap = true, expr = true, silent = true}},
    {lhs = '<S-Tab>', rhs = [[pumvisible() ? "\<C-p>": "\<S-Tab>"]], opts = {noremap = true, silent = true, expr = true}},
    {lhs = '<C-Space>', rhs = [[compe#complete()]], opts = {noremap = true, silent = true, expr = true}},
    {lhs = '<C-y>', rhs = [[compe#confirm('<CR>')]], opts = {noremap = true, silent = true, expr = true}},
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

-- ferret
vim.g.FerretMap = 0
helpers.create_mappings {
  n = {
    {lhs = '<leader>fa', rhs = '<Plug>(FerretAck)', opts = {}},
  }
}

-- vim-go
vim.g.go_def_mapping_enabled = 0
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_structs = 1
vim.g.go_fmt_command = 'goimports'

-- nvim-dap
vim.g.dap_virtual_text = true
