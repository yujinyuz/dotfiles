local opts = {noremap = true, silent = true}
local nvim_set_keymap = vim.api.nvim_set_keymap

nvim_set_keymap('n', '<leader>w', [[<cmd>update<CR>]], opts)
nvim_set_keymap('n', '<leader>qa', [[<cmd>qa!<CR>]], opts)

nvim_set_keymap('n', 'Q', 'gq', opts)

-- nvim_set_keymap('n', '<C-l>', [[<cmd>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>]], opts)
nvim_set_keymap('n', '<C-l>', [[<Cmd>nohl<CR>]], opts)



nvim_set_keymap('n', 'Y', 'y$', opts)
nvim_set_keymap('n', '<BS>', [[ <C-^> ]], opts)

nvim_set_keymap('i', 'jk', '<Esc>', opts)
