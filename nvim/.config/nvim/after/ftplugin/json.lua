vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

vim.cmd([[ command! Format :%!jq .]])

vim.keymap.nnoremap({ '<leader>cf', '<Cmd>Format<CR>', silent = true, buffer = true })
