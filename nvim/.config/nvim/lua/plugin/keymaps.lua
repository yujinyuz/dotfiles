local nnoremap = vim.keymap.nnoremap
local cnoremap = vim.keymap.cnoremap
local xnoremap = vim.keymap.xnoremap
local tnoremap = vim.keymap.tnoremap
local nmap = vim.keymap.nmap
local vmap = vim.keymap.vmap

local cmd = require('modules.lib.nvim_helpers').cmd_map

-- Write file when it is updated
nnoremap {'<leader>w', cmd 'update'}
-- Quit current
nnoremap {'<leader>qq', cmd 'q!'}
-- -- Quit all
nnoremap {'<leader>qa', cmd 'qa!'}
-- Blackhole delete
nnoremap {'<leader>d', '"_d'}
nnoremap {'Q', 'gq'}
-- Remove highlights
nnoremap {
  '<C-l>',
  [[<Cmd>nohlsearch<CR><Cmd>diffupdate<CR><C-l>]],
  silent = true,
}
-- Make Y work like other upcase commands
nnoremap {'Y', 'y$'}
-- Buffer Switch
nnoremap {'<BS>', '<C-^>'}
-- Resize splits with arrows
nnoremap {'<Up>', '<C-w>+'}
nnoremap {'<Down>', '<C-w>-'}
nnoremap {'<Left>', '<C-w><'}
nnoremap {'<Right>', '<C-w>>'}
nnoremap {'<leader>=', '<C-w>='}

-- Windows
nnoremap {'<C-j>', '<C-w>w'}
nnoremap {'<C-k>', '<C-w>W'}

-- Smooth scroll
nnoremap {'<C-y>', '3<C-y>'}
nnoremap {'<C-e>', '3<C-e>'}
-- Use Alt for moving lines up/down
nmap {'<M-j>', [[mz:m+<CR>`z]], silent = true}
nmap {'<M-k>', [[mz:m-2<CR>`z]], silent = true}
vmap {'<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]], silent = true}
vmap {'<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]], silent = true}
-- Create new file relative to the currently opened file
nnoremap {'<leader>fn', [[:e %:h<C-z>]]}

-- Delete other buffers except the current one
nnoremap {'<leader>1', cmd [[execute "%bd|e#|bd#"]]}

-- Save and execute
nnoremap {
  '<leader>x',
  cmd [[lua require('modules.lib.nvim_helpers').save_and_execute()]],
}

-- Command-line like navigation
cnoremap {'<C-j>', '<C-n>'}
cnoremap {'<C-k>', '<C-p>'}

-- Don't lose selection when shifting sidewards
xnoremap {'<', '<gv'}
xnoremap {'>', '>gv'}

tnoremap {'<Esc>', [[<C-\><C-n>]]}
tnoremap {'<M-h>', [[<C-\><C-n><C-w>h]]}
tnoremap {'<M-j>', [[<C-\><C-n><C-w>j]]}
tnoremap {'<M-k>', [[<C-\><C-n><C-w>k]]}
tnoremap {'<M-l>', [[<C-\><C-n><C-w>l]]}

-- nnoremap { '<leader>.', cmd 'edit %:p:h' }
-- nnoremap { '<leader>/', cmd 'edit .' }
