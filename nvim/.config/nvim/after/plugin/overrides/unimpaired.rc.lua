local utils = require('my.utils')

vim.keymap.set('n', 'yob', function()
  local has_config, config = pcall(require, 'gitsigns.config')

  if not has_config then
    utils.warn('cannot import config', 'gitsigns.nvim')
    return
  end

  if not config.signcolumn then
    utils.info('enabled gitsigns', 'Toggle')
  else
    utils.info('disabled gitsigns', 'Toggle')
  end

  vim.cmd([[
    Gitsigns toggle_current_line_blame
    Gitsigns toggle_signs
    Gitsigns toggle_linehl
    Gitsigns toggle_word_diff
  ]])
end, { desc = 'Toggle Gitsigns' })

vim.keymap.set('n', 'yof', function()
  require('my.lsp_format').toggle()
end, { desc = 'Format on Save' })
vim.keymap.set('n', 'yol', function()
  utils.toggle('number')
end, {})
vim.keymap.set('n', 'yoL', function()
  utils.toggle('list', true)
  utils.toggle_command('IndentBlanklineToggle')
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
