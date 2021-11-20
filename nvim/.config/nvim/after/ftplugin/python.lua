require('cmp').setup.buffer({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'rg', max_item_count = 5, keyword_length = 3},
    { name = 'path', max_item_count = 5 },
  },
})

