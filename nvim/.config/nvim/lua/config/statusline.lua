local lualine = require('lualine')
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
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_c = { { 'filename', file_status = true, path = 1 } },
    lualine_x = {
      { require('nvim-gps').get_location, cond = require('nvim-gps').is_available },
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
