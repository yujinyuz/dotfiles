local lualine = require('lualine')
local navic = require('nvim-navic')
local filename = function()
  -- local data = vim.fn.pathshorten(vim.fn.expand('%'))
  -- echo fnamemodify(expand("%"), ":~:.")
  local data = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')

  if data == '' then
    data = '[No Name]'
  end

  if vim.bo.modified then
    data = data .. ' [+]'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    data = data .. ' [-]'
  end
  return data
end

lualine.setup {
  options = {
    theme = 'auto',
    -- separator = '|',
    icons_enabled = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_c = { { 'filename', file_status = true, path = 1 } },
    lualine_x = {
      { navic.get_location, cond = navic.is_available },
      'encoding',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', file_status = true, path = 1 } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}
