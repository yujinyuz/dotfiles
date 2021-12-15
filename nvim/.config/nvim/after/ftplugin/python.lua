require('cmp').setup.buffer({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'rg' },
    { name = 'path' },
  },
})


local fterm = require('FTerm')

local pm_shell = fterm:new({
  ft = 'shell_plus',
  cmd = 'python manage.py shell_plus --print-sql',
})

-- Use this to toggle btop in a floating terminal
local function shell_plus()
  pm_shell:toggle()
end



vim.keymap.nnoremap({ '<A-x>', shell_plus })
vim.keymap.tnoremap({ '<A-x>', shell_plus })
