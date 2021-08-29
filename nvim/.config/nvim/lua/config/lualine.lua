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

lualine.setup({
  options = {
    theme = 'tokyonight',
    -- separator = '|',
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { filename },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
})
