require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
  close_triple_quotes = true,
})

require('nvim-autopairs.completion.compe').setup({
  map_cr = true,
  map_complete = true,
})
