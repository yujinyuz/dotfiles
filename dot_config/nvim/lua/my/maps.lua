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

-- Windows: Move between windows
-- The reason behind these keymaps is because I loved playing snake
-- during the Nokia days and I was just using it with 1/9 or 3/7 on the keypad
-- so even if I have more than 2 windows, these keymaps will just cycle through
-- all windows
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

vim.keymap.set('n', '<leader>w', '<Cmd>update<CR>', { desc = '[w]rite file changes if any' })

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
vim.keymap.set('n', '<leader>kd', function()
  if vim.b.diagnostic_virtual_text_config ~= nil then
    vim.diagnostic.config { virtual_text = vim.b.diagnostic_virtual_text_config }
    vim.b.diagnostic_virtual_text_config = nil
  else
    vim.b.diagnostic_virtual_text_config = vim.diagnostic.config().virtual_text
    vim.diagnostic.config { virtual_text = false }
  end
end, { desc = '[k]ill [d]iagnostic' })

vim.keymap.set('n', '<leader>.', function()
  vim.cmd.edit('%:p:h')
end, { desc = 'edit .' })
vim.keymap.set('n', '-', function()
  vim.cmd.edit('%:p:h')
end, { desc = 'edit . (vim-vinegar navigation)' })
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

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('my.format').format()
end, { desc = 'format buffer' })

vim.keymap.set('n', ',x', '<Cmd>write | :source %<CR>', { desc = 'source & e[x]ecute' })

vim.keymap.set('n', ',,', ',', { noremap = true, desc = 'repeat last f/F t/T command' })

vim.keymap.set('n', 'gV', '`[v`]', { desc = 'Select recently pasted text' })

-- Disable the Type :qa! message when pressing <C-c> in normal mode
vim.keymap.set('n', '<C-c>', '<Nop>', { noremap = true })

-- Automatically center the screen when searching
vim.keymap.set('n', 'n', 'nzzzv', { desc = "Fwd  search '/' or '?'" })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = "Back search '/' or '?'" })
vim.keymap.set('c', '<CR>', function()
  return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>'
end, { expr = true })

vim.keymap.set({ 'n', 'x' }, '@', function()
  vim.cmd('noautocmd norm! ' .. vim.v.count1 .. '@' .. vim.fn.getcharstr())
end, { noremap = true })

vim.keymap.set('n', 'dd', function()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end, { noremap = true, expr = true, desc = 'Smart delete' })
