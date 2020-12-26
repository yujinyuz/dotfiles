-- Here resides some config files that require minimal config

local nvim_set_keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- vim-fugitive
nvim_set_keymap('n', '<leader>gs', [[<cmd>Git<CR>]], opts)

-- vim-dirvish
nvim_set_keymap('n', '<leader>.', [[<cmd>Dirvish<CR>]], opts)

-- Disable netrw
vim.g.loaded_netrwPlugin = 1

-- undotree
vim.g.undotree_HighlightChangedWithSign = 0
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SetFocusWhenToggle = 1
nvim_set_keymap('n', '<leader>u', [[<cmd>UndoTreeToggle<CR>]], opts)

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
nvim_set_keymap('n', '\b', [[<cmd>Vista!!<CR>]], opts)
