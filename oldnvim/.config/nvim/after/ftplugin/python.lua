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

-- Surround word with Optional
-- e.g. str -> Optional[str] = None
vim.keymap.set('n', '<leader>o', 'iOptional[<C-o>A] = None<Esc>', { buffer = 0 })
