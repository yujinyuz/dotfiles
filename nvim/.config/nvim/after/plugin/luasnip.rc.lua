local has_luasnip, luasnip = pcall(require, 'luasnip')
if not has_luasnip then
  return
end

luasnip.config.setup {
  history = true,
  -- Update more often, :h events for more info.
  updateevents = 'TextChanged,TextChangedI',
}

require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set('i', '<C-l>', function()
  luasnip.expand()
end, { desc = 'Expand Snippet' })
