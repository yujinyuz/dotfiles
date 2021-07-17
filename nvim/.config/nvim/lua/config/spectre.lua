local nnoremap = vim.keymap.nnoremap

require('spectre').setup {}

nnoremap {'<leader>S', function() require('spectre').open() end}
