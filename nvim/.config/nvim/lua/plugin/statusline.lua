local lualine = require('lualine')
local function custom_filename()
  local data = vim.fn.pathshorten(vim.fn.expand('%'))

  if data == '' then
    data = '[No Name]'
  end

  if vim.bo.modified then
    data = data .. ' [+]'
  elseif vim.bo.modifiable == false then
    data = data .. ' [-]'
  end
  return data
end

lualine.options = {
  theme = 'gruvbox_material',
  separator = '|',
  icons_enabled = true,
}

lualine.sections = {
  lualine_a = { 'mode' },
  lualine_b = { 'branch' },
  lualine_c = { custom_filename },
  lualine_x = { 'encoding', 'fileformat', 'filetype' },
  lualine_y = { 'progress' },
  lualine_z = { 'location'  },
}
lualine.inactive_sections = {
  lualine_a = {  },
  lualine_b = {  },
  lualine_c = { custom_filename },
  lualine_x = { 'location' },
  lualine_y = {  },
  lualine_z = {   }
}
lualine.status()
