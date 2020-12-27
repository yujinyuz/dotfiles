local helpers = require('jyz.lib.nvim_helpers')
local set_keymap = helpers.set_keymap

-- Write file when it is updated
set_keymap('n', '<leader>w', helpers.cmd_map('update'), {})
-- Quit all
set_keymap('n', '<leader>qa', helpers.cmd_map('qa!'), {})
-- Quit current
set_keymap('n', '<leader>qq', helpers.cmd_map('q!'), {})

-- Blackhole delete
set_keymap('n', '<leader>d', '"_d', {})

set_keymap('n', 'Q', 'gq', {})
--
-- Make it easier when navigating through pums
set_keymap('i', '<C-j>', '<C-n>', {})
set_keymap('i', '<C-k>', '<C-p>', {})

-- Remove highlights
set_keymap('n', '<C-l>', helpers.cmd_map('nohl'), {})

-- Make Y work like other upcase commands
set_keymap('n', 'Y', 'y$', {})
-- Buffer Switch
set_keymap('n', '<BS>', '<C-^>', {})
-- Stay in visual mode when indenting
set_keymap('v', '<', '<gv', {})
set_keymap('v', '>', '>gv', {})

-- Command-line like navigation
set_keymap('c', '<C-k>', '<Up>', {})
set_keymap('c', '<C-j>', '<Down>', {})

-- Resize splits with arrows
set_keymap('n', '<Up>', helpers.cmd_map('resize +2'), {})
set_keymap('n', '<Down>', helpers.cmd_map('resize -2'), {})
set_keymap('n', '<Left>', helpers.cmd_map('vertical resize +2'), {})
set_keymap('n', '<Right>', helpers.cmd_map('vertical resize -2'), {})

-- Smooth scroll
set_keymap('n', '<C-y>', '3<C-y>', {})
set_keymap('n', '<C-e>', '3<C-e>', {})

-- Use Alt for moving lines up/down
set_keymap('n', '<A-j>', [[mz:m+<CR>`z]], {})
set_keymap('n', '<A-k>', [[mz:m-2<CR>`z]], {})
set_keymap('v', '<A-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]], {})
set_keymap('v', '<A-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]], {})

-- Utilities
set_keymap('n', '<leader>fn', [[<Cmd>e %:h<C-z>]], {})
set_keymap('n', '<leader>ot', helpers.cmd_map([[rightbelow split<CR><Cmd>exec "resize " . (winheight(0) * 2/3)<CR><Cmd>e term://fish]]), {})
set_keymap('t', '<Esc>', [[<C-\><C-n>]], {})
set_keymap('t', '<A-h>', [[<C-\><C-n><C-w>h]], {})
set_keymap('t', '<A-h>', [[<C-\><C-n><C-w>h]], {})
set_keymap('t', '<A-j>', [[<C-\><C-n><C-w>j]], {})
set_keymap('t', '<A-k>', [[<C-\><C-n><C-w>k]], {})
set_keymap('i', '<A-l>', [[<C-\><C-n><C-w>l]], {})
set_keymap('i', '<A-j>', [[<C-\><C-n><C-w>j]], {})
set_keymap('i', '<A-k>', [[<C-\><C-n><C-w>k]], {})
set_keymap('i', '<A-l>', [[<C-\><C-n><C-w>l]], {})
-- set_keymap('n', '<A-h>', [[<C-w>h]], {})
-- set_keymap('n', '<A-j>', [[<C-w>j]], {})
-- set_keymap('n', '<A-k>', [[<C-w>k]], {})
-- set_keymap('n', '<A-l>', [[<C-w>l]], {})

