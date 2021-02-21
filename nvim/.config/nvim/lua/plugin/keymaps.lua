local shell = os.getenv('SHELL')

local nnoremap = vim.keymap.nnoremap
local cnoremap = vim.keymap.cnoremap
local xnoremap = vim.keymap.xnoremap
local vnoremap = vim.keymap.vnoremap
local tnoremap = vim.keymap.tnoremap

local cmd = require('jyz.lib.nvim_helpers').cmd_map

-- Write file when it is updated
nnoremap { '<leader>w', cmd 'update' }
-- Quit current
nnoremap { '<leader>qq', cmd 'q!' }
-- -- Quit all
nnoremap { '<leader>qa', cmd 'qa!' }
-- Blackhole delete
nnoremap { '<leader>d', '"_d' }
nnoremap { 'Q', 'gq' }
-- Remove highlights
nnoremap { '<C-l>', [[:nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>]], silent = true }
-- Make Y work like other upcase commands
nnoremap { 'Y', 'y$' }
-- Buffer Switch
nnoremap { '<BS>', '<C-^>' }
-- Resize splits with arrows
nnoremap { '<Up>', '<C-w>+' }
nnoremap { '<Down>', '<C-w>-' }
nnoremap { '<Left>', '<C-w><' }
nnoremap { '<Right>', '<C-w>>' }
nnoremap { '<leader>=', '<C-w>=' }
-- Smooth scroll
nnoremap { '<C-y>', '3<C-y>' }
nnoremap { '<C-e>', '3<C-e>' }
-- Use Alt for moving lines up/down
nnoremap { '<M-j>', [[mz:m+`z]] }
nnoremap { '<M-k>', [[mz:m-2`z]] }
vnoremap { '<M-j>', [[:m'>+`<my`>mzgv`yo`z]] }
vnoremap { '<M-k>', [[:m'<-2`>my`<mzgv`yo`z]] }
-- Create new file relative to the currently opened file
nnoremap { '<leader>fn', [[:e %:h<C-z>]] }

-- Save and execute
nnoremap { '<leader>x', cmd [[lua require('jyz.lib.nvim_helpers').save_and_execute()]] }
-- -- Open new terminal
nnoremap { '<leader>ot', cmd [[rightbelow splitexec "resize " . (winheight(0) * 2/3)e term://]] .. shell }

-- Command-line like navigation
cnoremap { '<C-j>', '<C-n>' }
cnoremap { '<C-k>', '<C-p>' }

-- Don't lose selection when shifting sidewards
xnoremap { '<', '<gv' }
xnoremap { '>', '>gv' }

tnoremap { '<Esc>', [[<C-\><C-n>]] }
tnoremap { '<M-h>', [[<C-\><C-n><C-w>h]] }
tnoremap { '<M-j>', [[<C-\><C-n><C-w>j]] }
tnoremap { '<M-k>', [[<C-\><C-n><C-w>k]] }
tnoremap { '<M-l>', [[<C-\><C-n><C-w>l]] }
