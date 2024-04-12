vim.opt_local.spell = true
vim.opt_local.conceallevel = 0
vim.opt_local.concealcursor = 'n'
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 100
vim.opt_local.formatprg = 'safe-par rTbqR B=.,\\?_A_a_0 Q=_s\\>\\| -w' .. vim.opt_local.textwidth:get()
vim.opt_local.colorcolumn = { vim.opt_local.textwidth:get() }

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

-- Mnemonic for [i]dea

vim.keymap.set('n', '<leader>i', function()
  local n_lines = vim.api.nvim_buf_line_count(0)
  local lines = { '', '## ' .. vim.fn.strftime('%H:%M'), '', '' }
  vim.api.nvim_buf_set_lines(0, -1, -1, true, lines)
  vim.api.nvim_win_set_cursor(0, { #lines + n_lines, 0 })
  vim.cmd.startinsert()
end, { buffer = 0 })

vim.keymap.set('n', '<leader>pm', '<Cmd>MarkdownPreviewToggle<CR>', { buffer = 0 })

-- Fix textwidth
-- %!fold -w 60
