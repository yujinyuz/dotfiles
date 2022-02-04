local fterm = require('FTerm')

local pm_shell = fterm:new {
  ft = 'shell_plus',
  cmd = 'python manage.py shell_plus --print-sql',
}

-- Use this to toggle btop in a floating terminal
local function shell_plus()
  pm_shell:toggle()
end

vim.keymap.set({ 'n', 't' }, '<A-x>', shell_plus)
