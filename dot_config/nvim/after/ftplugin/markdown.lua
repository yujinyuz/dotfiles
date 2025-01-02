vim.opt_local.spell = true
vim.opt_local.conceallevel = 0
vim.opt_local.concealcursor = 'n'
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 100
vim.opt_local.formatprg = 'safe-par rTbqR B=.,\\?_A_a_0 Q=_s\\>\\| -w' .. vim.bo.textwidth
vim.opt_local.colorcolumn = { vim.bo.textwidth }

vim.keymap.set('i', ';H', '<Esc>yypv$r=', { buffer = 0 })
vim.keymap.set('i', ';h', '<Esc>yypv$r-', { buffer = 0 })

vim.keymap.set('i', ';d', function()
  return vim.fn.strftime('## %A, %B %d, %Y\n\n\n')
end, { buffer = 0, expr = true })

vim.keymap.set('i', ';D', function()
  return vim.fn.strftime('### %Y-%m-%d\n\n\n')
end, { buffer = 0, expr = true })

vim.keymap.set('i', ';t', function()
  return vim.fn.strftime('### %H:%M\n\n\n')
end, { buffer = 0, expr = true })

vim.keymap.set('n', '<leader>pm', '<Cmd>MarkdownPreviewToggle<CR>', { buffer = 0 })

vim.keymap.set('i', ';e', '<!-- end_slide -->', { nowait = true })
vim.keymap.set('i', ';p', '<!-- pause -->', { nowait = true })
