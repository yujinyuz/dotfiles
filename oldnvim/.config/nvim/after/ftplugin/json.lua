vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4




vim.cmd([[ command! Format :%!jq .]])

vim.keymap.set('n', '<leader>cf', '<Cmd>Format<CR>', { silent = true, buffer = 0, desc = 'Format JSON' })

