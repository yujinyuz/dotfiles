local has_neogit, neogit = pcall(require, 'neogit')
if not has_neogit then
  return
end

neogit.setup {
  integrations = { diffview = true },
  disable_commit_confirmation = true,
}

vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<CR>')
