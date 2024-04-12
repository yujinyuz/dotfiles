local utils = require('my.utils')

local gitsigns_enabled = false

vim.keymap.set('n', 'yob', function()
  local _, gs = pcall(require, 'gitsigns')

  if not gs then
    utils.warn('gitsigns.nvim is not installed', '[vim-unimpaired]')
    return
  end

  gitsigns_enabled = not gitsigns_enabled

  if gitsigns_enabled then
    utils.info('enabled gitsigns', 'Toggle')
  else
    print('disabled')
    utils.warn('disabled gitsigns', 'Toggle')
  end

  gs.toggle_current_line_blame()
  gs.toggle_signs()
  gs.toggle_linehl()
  gs.toggle_word_diff()
end, { desc = 'Toggle Gitsigns' })

vim.keymap.set('n', 'yof', function()
  require('my.format').toggle()
end, { desc = 'Format on Save' })
vim.keymap.set('n', 'yol', function()
  utils.toggle('number')
end, {})
vim.keymap.set('n', 'yoL', function()
  vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
  utils.toggle('list', true)
end)
vim.keymap.set('n', 'yor', function()
  utils.toggle('relativenumber')
end)
vim.keymap.set('n', 'yos', function()
  utils.toggle('spell')
end)
vim.keymap.set('n', 'yow', function()
  utils.toggle('wrap')
end)

vim.keymap.set('n', 'yoC', function()
  vim.b.colorcolumn_t = not vim.b.colorcolumn_t

  -- Check if colorcolumn_opt is set or use default value
  vim.b.colorcolumn_opt = vim.b.colorcolumn_opt or { 100 }

  if vim.b.colorcolumn_t then
    vim.opt_local.colorcolumn = vim.b.colorcolumn_opt
    utils.info('enabled cursorcolumn', 'Toggle')
  else
    vim.opt_local.colorcolumn = {}
    utils.warn('enabled cursorcolumn', 'Toggle')
  end
end)
