local ide_group = vim.api.nvim_create_augroup('IDECallbacks', { clear = true })

-- Return to last edit position
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    local ft = vim.opt_local.filetype:get()
    -- don't apply to git messages
    if ft:match('commit') or ft:match('rebase') then
      return
    end
    -- get position of last saved edit
    local line, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    -- if in range, go there
    if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
      vim.api.nvim_win_set_cursor(0, { line, col })
    end
  end,
  desc = 'Return to Last Edit Position',
})

-- Highight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    vim.highlight.on_yank {
      higroup = 'Substitute',
      on_visual = false,
      timeout = 200,
    }
  end,
  desc = 'Highight on Yank',
})

-- Strip Trailing Whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    local ft = vim.opt_local.filetype:get()
    if ft:match('commit') or ft:match('rebase') then
      return
    end

    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
  desc = 'Strip Trailing Whitespace',
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    vim.opt_local.signcolumn = 'no'
  end,
  desc = 'Start Terminal Insert',
})

vim.api.nvim_create_autocmd({
  'BufEnter',
  'FocusGained',
  'InsertLeave',
  'WinEnter',
}, {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    if vim.opt.number:get() and vim.fn.mode() ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
  desc = 'Enable relativenumber',
})

vim.api.nvim_create_autocmd({
  'BufLeave',
  'FocusLost',
  'InsertEnter',
  'WinLeave',
}, {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
  desc = 'Disable relative number',
})

vim.api.nvim_create_autocmd('VimResized', {
  pattern = { '*' },
  group = ide_group,
  command = 'wincmd =',
  desc = 'Automatically Resize Windows Equally',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    -- vim.cmd [[let &bex = substitute(expand('%:p:h'), '/', ':', 'g') . strftime('%F.%H:%M')]]
    vim.cmd [[let &bex = '@' . strftime("%F.%H:%M")]]
  end,
  desc = 'Rename backup files',
})
