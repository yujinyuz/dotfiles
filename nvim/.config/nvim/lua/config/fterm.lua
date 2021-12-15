require('FTerm').setup({})

local fterm = require('FTerm')

local htop = fterm:new({
  ft = 'fterm_btop',
  cmd = 'htop',
})

-- Use this to toggle btop in a floating terminal
local function fterm_htop()
  htop:toggle()
end



vim.keymap.nnoremap({ '<A-h>', fterm_htop })
vim.keymap.tnoremap({ '<A-h>', fterm_htop })
