require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
  close_triple_quotes = true,
})

require('nvim-autopairs.completion.cmp').setup({
  map_cr = true,
  map_complete = true,
  auto_select = false,
})
