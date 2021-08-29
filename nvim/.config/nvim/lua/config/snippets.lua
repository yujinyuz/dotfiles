local luasnip = require('luasnip')

luasnip.config.setup({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = 'TextChanged,TextChangedI',
})

require('luasnip/loaders/from_vscode').lazy_load()

vim.keymap.inoremap({
  '<C-l>',
  function()
    require('luasnip').expand()
  end,
})
