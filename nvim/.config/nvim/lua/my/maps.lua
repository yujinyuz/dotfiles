-- General keymaps that aren't specific to plugins

-- Prevent accidentally opening ex mode
vim.keymap.set('n', 'Q', '"_')

-- Create new file
vim.keymap.set('n', '<leader>fn', [[:e %:h<C-z>]], { desc = 'Create new file relative to current file' })

vim.keymap.set('n', '<BS>', '<C-^>', { desc = '[B]uffer [S]witch' })

-- Resize splits with Shift + Arrow Keys
vim.keymap.set('n', '<S-Up>', '<C-w>+')
vim.keymap.set('n', '<S-Down>', '<C-w>-')
vim.keymap.set('n', '<S-Left>', '<C-w><')
vim.keymap.set('n', '<S-Right>', '<C-w>>')

-- Windows
vim.keymap.set('n', '<C-j>', '<C-w>w')
vim.keymap.set('n', '<C-k>', '<C-w>W')

-- Smooth scroll
vim.keymap.set('n', '<C-y>', '3<C-y>')
vim.keymap.set('n', '<C-e>', '3<C-e>')

-- Use Alt for moving lines up/down
vim.keymap.set('n', '<M-j>', [[mz:m+<CR>`z]], { silent = true })
vim.keymap.set('n', '<M-k>', [[mz:m-2<CR>`z]], { silent = true })
vim.keymap.set('v', '<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]], { silent = true })
vim.keymap.set('v', '<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]], { silent = true })

-- Command-line like navigation
vim.keymap.set('c', '<C-j>', '<C-n>')
vim.keymap.set('c', '<C-k>', '<C-p>')

-- Don't lose selection when shifting sidewards
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<M-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<M-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<M-k>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<M-l>', [[<C-\><C-n><C-w>l]])

vim.keymap.set('c', 'w!!', require('my.utils').sudo_write, { silent = true, desc = 'Sudo Write' })

vim.keymap.set('n', '<C-p>', ':e **/', { desc = 'Backup file finder' })

vim.keymap.set('n', '<leader>qq', '<Cmd>q!<CR>', { desc = '[Q]uick [q]uit without saving' })
vim.keymap.set('n', '<leader>qa', '<Cmd>qa!<CR>', { desc = '[Q]uit [a]ll without saving' })

vim.keymap.set('n', '<leader>w', '<Cmd>update!<CR>', { desc = '[w]rite but only if file has changes' })

-- Store relative line number jumps in the jumplist if they exceed a threshold.
vim.keymap.set('n', 'k', function()
  return (vim.v.count > 5 and "m'" .. vim.v.count or '') .. 'gk'
end, { expr = true })
vim.keymap.set('n', 'j', function()
  return (vim.v.count > 5 and "m'" .. vim.v.count or '') .. 'gj'
end, { expr = true })

vim.keymap.set('n', '<leader>fixformat', function()
  print(':e ++ff=dos followed by :set ff=unix')
end, { desc = 'Tells Vim to read the file again, forcing dos file format. Repairs ^M characters' })

-- Diagnostics. Not necessarily related to LSP
vim.keymap.set('n', '<leader>cd', function()
  vim.diagnostic.open_float()
end, { desc = 'Line diagnostics ' })
vim.keymap.set('n', '[w', vim.diagnostic.goto_prev, { desc = 'Goto Previous Diagnostic' })
vim.keymap.set('n', ']w', vim.diagnostic.goto_next, { desc = 'Goto Next Diagnostic' })

vim.keymap.set('n', '<leader>.', function()
  vim.cmd.edit('%:p:h')
end, { desc = 'edit .' })
vim.keymap.set('n', '<leader>/', function()
  vim.cmd.edit('.')
end, { desc = 'edit root' })

vim.keymap.set('n', 'y.', function()
  local filename = vim.fn.expand('%:t')
  vim.fn.setreg('+', filename)
  require('my.utils').info("Copied '" .. filename .. "' to system clipboard")
end, { desc = 'copy current filename to system clipboard' })

vim.keymap.set('n', 'y/', function()
  local filepath = vim.fn.expand('%:p:.')
  vim.fn.setreg('+', filepath)
  require('my.utils').info("Copied '" .. filepath .. "' to system clipboard")
end, { desc = 'copy current file path to system clipboard (without the root dir)' })

vim.keymap.set('n', 'y,', function()
  local filepath = vim.fn.expand('%:p')
  vim.fn.setreg('+', filepath)
  require('my.utils').info("Copied '" .. filepath .. "' to system clipboard")
end, { desc = 'copy current absolute filename to system clipboard' })

vim.keymap.set('n', '<leader>cf', function()
  require('my.format').format()
end)
