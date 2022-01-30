local gp = require('goto-preview')

gp.setup({})

vim.keymap.set('n', 'gpd', function()
  gp.goto_preview_definition()
end)

vim.keymap.set('n', 'gpi', function()
  gp.goto_preview_implementation()
end)

vim.keymap.set('n', 'gpr', function()
  gp.goto_preview_references()
end)

vim.keymap.set('n', 'gP', function()
  gp.close_all_win()
end)
