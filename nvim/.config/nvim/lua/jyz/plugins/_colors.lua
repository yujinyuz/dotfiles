vim.o.termguicolors = true
vim.cmd([[ colorscheme gruvbox ]])
require('colorizer').setup{}

if vim.g.colors_name == 'gruvbox' then
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_invert_selection = 0
end
