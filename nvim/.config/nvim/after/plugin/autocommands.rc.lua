local ide_group = vim.api.nvim_create_augroup('IDECallbacks', { clear = true })

-- Highight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = { '*' },
  group = ide_group,
  callback = function()
    vim.highlight.on_yank {
      -- higroup = 'Substitute',
      higroup = 'IncSearch',
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
    vim.cmd([[let &bex = strftime("📅%F⏰%X") .. '✍️']])
  end,
  desc = 'Rename backup files',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = ide_group,
  pattern = { '*/kitty/*.conf' },
  callback = function()
    -- auto-reload kitty upon kitty.conf write
    -- https://github.com/kovidgoyal/kitty/discussions/5416#discussioncomment-3473122
    vim.cmd([[:silent !pgrep -i kitty | xargs kill -SIGUSR1 $KITTY_PID]])
  end,
})
