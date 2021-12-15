local gp = require('goto-preview')

gp.setup()

vim.keymap.nnoremap({'gpd', function() gp.goto_preview_definition() end})
vim.keymap.nnoremap({'gpi', function() gp.goto_preview_implementation() end})
vim.keymap.nnoremap({'gpr', function() gp.goto_preview_references() end})
vim.keymap.nnoremap({'gP', function() gp.close_all_win() end})
