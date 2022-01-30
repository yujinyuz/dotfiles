-- vim.opt_local.spell = true
-- vim.opt_local.conceallevel = 3
-- vim.opt_local.concealcursor = 'n'

vim.cmd([[
  setlocal spell conceallevel=3 concealcursor=n
]])

require('cmp').setup.buffer({
  sources = {
    { name = 'look', keyword_length = 2, max_item_count = 10, options = { convert_case = true, loud = true } },
    { name = 'rg', max_item_count = 10, keyword_length = 3 },
    { name = 'buffer', max_item_count = 10, keyword_length = 3 },
    { name = 'calc' },
  },
})

vim.keymap.set('i', ';H', '<Esc>yypv$r=', { buffer = 0 })
vim.keymap.set('i', ';h', '<Esc>yypv$r-', { buffer = 0 })
vim.keymap.set('i', ';t', '## <C-R>=strftime("%H:%M")<CR><CR><CR><CR>', { buffer = 0 })

-- Mnemonic for [i]dea
vim.keymap.set(
  'n',
  '<leader>i',
  'Go<CR>## <C-R>=strftime("%H:%M")<CR><Esc>zzA<CR><CR>',
  { buffer = 0, silent = true }
)
