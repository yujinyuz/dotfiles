require('FTerm').setup {}

vim.keymap.nnoremap {'<leader>ot', function() require('FTerm').toggle() end}
vim.keymap.tnoremap {'<leader>ot', function() require('FTerm').toggle() end}

vim.keymap.nnoremap {'<A-i>', function() require('FTerm').toggle() end}
vim.keymap.tnoremap {'<A-i>', function() require('FTerm').toggle() end}
