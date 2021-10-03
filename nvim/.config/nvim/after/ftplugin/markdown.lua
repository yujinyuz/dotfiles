-- vim.opt_local.spell = true
-- vim.opt_local.conceallevel = 3
-- vim.opt_local.concealcursor = 'n'

vim.cmd [[
  setlocal spell conceallevel=3 concealcursor=n
]]

require('cmp').setup.buffer({
  sources = {
    { name = 'buffer' },
    { name = 'calc' },
  },
})
