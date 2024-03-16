vim.opt_local.spell = true
vim.opt_local.conceallevel = 0
vim.opt_local.concealcursor = 'n'
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 100
vim.opt_local.formatprg = 'safe-par rTbqR B=.,\\?_A_a_0 Q=_s\\>\\| -w' .. vim.opt_local.textwidth:get()

vim.keymap.set('i', ';H', '<Esc>yypv$r=', { buffer = 0 })
vim.keymap.set('i', ';h', '<Esc>yypv$r-', { buffer = 0 })

vim.keymap.set('i', ';d', '## <C-R>=strftime("%A, %B %d, %Y")<CR><CR><CR>', { buffer = 0 })
vim.keymap.set('i', ';D', '### <C-R>=strftime("%Y-%m-%d")<CR><CR><CR>', { buffer = 0 })
vim.keymap.set('i', ';t', '### <C-R>=strftime("%H:%M")<CR><CR><CR>', { buffer = 0 })

-- Mnemonic for [i]dea
vim.keymap.set('n', '<leader>i', 'Go<CR>## <C-R>=strftime("%H:%M")<CR><Esc>zzA<CR><CR>', { buffer = 0, silent = true })

vim.keymap.set('n', '<leader>pm', '<Cmd>MarkdownPreviewToggle<CR>', { buffer = 0 })

-- Fix textwidth
-- %!fold -w 60
