vim.o.termguicolors = true
-- require('colorbuddy').colorscheme('gruvbuddy')
-- require('colorbuddy').colorscheme('onebuddy')
-- require('colorbuddy').colorscheme('nvim-gruvbox')
vim.cmd([[ colorscheme gruvbox-material ]])
require('colorizer').setup{}

if vim.g.colors_name == 'gruvbox' then
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_invert_selection = 0
end
