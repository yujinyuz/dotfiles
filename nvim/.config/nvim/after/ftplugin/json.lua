vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

vim.cmd([[ command! Format :%!jq .]])

vim.keymap.set('n', '<leader>cf', '<Cmd>Format<CR>', { silent = true, buffer = 0 })
