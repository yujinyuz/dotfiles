local function copy_as_pytest()
  local navic_data = require('nvim-navic').get_data()

  local filepath = vim.fn.expand('%:p:.')
  local tbl = {}

  table.insert(tbl, filepath)
  for _, data in ipairs(navic_data) do
    table.insert(tbl, data.name)
  end

  local pytest_test_path = table.concat(tbl, '::')

  vim.fn.setreg('+', pytest_test_path)
  return pytest_test_path
end

-- Override the default <C-s> keybinding to copy the current location as a pytest
vim.keymap.set('n', '<C-s>', function()
  vim.api.nvim_echo({ { copy_as_pytest(), 'String' } }, true, {})
end, { buffer = 0 })
