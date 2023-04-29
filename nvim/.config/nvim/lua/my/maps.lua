-- General keymaps that aren't specific to plugins

-- Prevent accidentally opening ex mode
vim.keymap.set('n', 'Q', '"_')

-- Create new file
vim.keymap.set('n', '<leader>fn', [[:e %:h<C-z>]], { desc = 'Create new file relative to current file' })

-- Buffer Switch
vim.keymap.set('n', '<BS>', '<C-^>')

-- Resize splits with Shift + Arrow Keys
vim.keymap.set('n', '<S-Up>', '<C-w>+')
vim.keymap.set('n', '<S-Down>', '<C-w>-')
vim.keymap.set('n', '<S-Left>', '<C-w><')
vim.keymap.set('n', '<S-Right>', '<C-w>>')
vim.keymap.set('n', '<leader>=', '<C-w>=')

-- Windows
vim.keymap.set('n', '<C-j>', '<C-w>w')
vim.keymap.set('n', '<C-k>', '<C-w>W')

-- Navigate to splits with arrow keys
vim.keymap.set('n', '<Left>', '<C-w>h')
vim.keymap.set('n', '<Right>', '<C-w>l')
vim.keymap.set('n', '<Up>', '<C-w>k')
vim.keymap.set('n', '<Down>', '<C-w>j')

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

-- Persistent highlights
vim.keymap.set('n', '<leader>ll', [[<Cmd>call matchadd('Visual', '\%'.line('.').'l')<CR>]], { silent = true })
vim.keymap.set('n', '<leader>lc', [[<Cmd>call clearmatches()<CR>]], { silent = true })

vim.keymap.set('c', 'w!!', require('my.utils').sudo_write, { silent = true })

-- Just a backup finder
vim.keymap.set('n', '<C-p>', ':e **/')

-- Execute and save file
vim.keymap.set('n', '<leader>fx', ':update<CR>|:source<CR>', { desc = 'Save and execute current file' })

vim.keymap.set('n', '<leader>qq', '<Cmd>q!<CR>', { desc = 'Quick quit without saving' })
vim.keymap.set('n', '<leader>qa', '<Cmd>qa!<CR>', { desc = 'Quit all without saving' })

vim.keymap.set('n', '<leader>w', '<Cmd>update!<CR>')

vim.keymap.set('n', 'k', function()
  return (vim.v.count > 5 and "m'" .. vim.v.count or '') .. 'gk'
end, { expr = true })
vim.keymap.set('n', 'j', function()
  return (vim.v.count > 5 and "m'" .. vim.v.count or '') .. 'gj'
end, { expr = true })

vim.keymap.set('n', '<leader>fixformat', function()
  print(':e ++ff=dos followed by :set ff=unix')
end, { desc = 'Tells Vim to read the file again, forcing dos file format' })

-- Diagnostics. Not necessarily related to LSP
vim.keymap.set('n', '<leader>cd', function()
  vim.diagnostic.open_float()
end, {})
vim.keymap.set('n', '[w', vim.diagnostic.goto_prev, {})
vim.keymap.set('n', ']w', vim.diagnostic.goto_next, {})

