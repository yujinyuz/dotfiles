local fterm = require('FTerm')

local pm_shell = fterm:new {
  ft = 'shell_plus',
  -- Sometimes manage.py is located inside src/ or some other directory
  cmd = (vim.env.DJANGO_MANAGE_PY or 'python manage.py') .. ' shell_plus',
}

vim.api.nvim_create_user_command('ShellPlus', function()
  pm_shell:toggle()
end, { bang = true })

-- Use this to toggle btop in a floating terminal
local function shell_plus()
  pm_shell:toggle()
end

vim.keymap.set({ 'n', 't' }, '<A-x>', shell_plus)

-- Surround word with Optional
-- e.g. str -> Optional[str] = None
vim.keymap.set('n', '<leader>o', 'iOptional[<C-o>A] = None<Esc>', { buffer = 0 })
