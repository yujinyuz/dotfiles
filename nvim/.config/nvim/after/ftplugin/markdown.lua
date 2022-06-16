-- Doing this instead ot the lua version because `vim.opt_local` seems to be quite buggy as of now
vim.cmd([[
  setlocal spell conceallevel=0 concealcursor=n textwidth=100
]])
-- vim.opt_local.spell = true
-- vim.opt_local.conceallevel = 3
-- vim.opt_local.concealcursor = 'n'

vim.keymap.set('i', ';H', '<Esc>yypv$r=', { buffer = 0 })
vim.keymap.set('i', ';h', '<Esc>yypv$r-', { buffer = 0 })
vim.keymap.set('i', ';t', '## <C-R>=strftime("%H:%M")<CR><CR><CR><CR>', { buffer = 0 })

-- Mnemonic for [i]dea
vim.keymap.set('n', '<leader>i', 'Go<CR>## <C-R>=strftime("%H:%M")<CR><Esc>zzA<CR><CR>', { buffer = 0, silent = true })

vim.keymap.set('n', '<leader>pm', '<Cmd>MarkdownPreviewToggle<CR>', { buffer = 0 })
