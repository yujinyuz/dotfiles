local utils = require('my.utils')

vim.keymap.set('n', 'yob', function()
  local _, gs = pcall(require, 'gitsigns')

  if not gs then
    utils.warn('gitsigns.nvim is not installed', '[unimpaired-overrides]')
    return
  end

  vim.b.gitsigns_t_state = not vim.b.gitsigns_t_state

  if vim.b.gitsigns_t_state then
    utils.info('enabled gitsigns', 'Toggle')
  else
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
  utils.toggle_opt('list')
end, {})

vim.keymap.set('n', 'yoL', function()
  vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable

  if vim.g.miniindentscope_disable then
    utils.warn('disabled mini.indentscope', 'Toggle')
  else
    utils.info('enabled mini.indentscope', 'Toggle')
  end
end)

vim.keymap.set('n', 'yor', function()
  utils.toggle_opt('relativenumber')
end)

vim.keymap.set('n', 'yon', function()
  utils.toggle_opt('number')
end)

vim.keymap.set('n', 'yos', function()
  utils.toggle_opt('spell')
end)
vim.keymap.set('n', 'yow', function()
  utils.toggle_opt('wrap')
end)

vim.keymap.set('n', 'yoC', function()
  vim.b.colorcolumn_t_state = not vim.b.colorcolumn_t_state

  -- Check if colorcolumn_opt is set or use default value
  vim.b.colorcolumn_opt = vim.b.colorcolumn_opt or { 100 }

  if vim.b.colorcolumn_t_state then
    vim.opt_local.colorcolumn = vim.b.colorcolumn_opt
    utils.info('enabled cursorcolumn', 'Toggle')
  else
    vim.opt_local.colorcolumn = {}
    utils.warn('enabled cursorcolumn', 'Toggle')
  end
end)
