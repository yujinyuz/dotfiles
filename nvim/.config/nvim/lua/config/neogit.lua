local nnoremap = vim.keymap.nnoremap

require('neogit').setup {
  integrations = {diffview = true},
  disable_commit_confirmation = true,
}

nnoremap {'<leader>gg', [[<Cmd>Neogit<CR>]]}
