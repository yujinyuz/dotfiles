vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.api.nvim_create_user_command('Format', ':%!jq . --indent 4', {})

vim.keymap.set('n', '<leader>cf', '<Cmd>Format<CR>', { silent = true, buffer = 0, desc = 'Format JSON' })
