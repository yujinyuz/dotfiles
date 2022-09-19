local has_lualine, lualine = pcall(require, 'lualine')
if not has_lualine then
  return
end

local navic = require('nvim-navic')

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
