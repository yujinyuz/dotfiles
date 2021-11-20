-- nvim runtime overrides our `formatoptions` just remove the unwated stuff here
vim.opt_local.formatoptions:remove('o')

require('cmp').setup.buffer({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'rg' },
    { name = 'path' },
  },
})
