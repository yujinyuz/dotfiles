local function augroup(name)
  return vim.api.nvim_create_augroup('pde_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = { '*' },
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank {
      on_visual = false,
      timeout = 200,
    }
  end,
  desc = 'Highight on Yank',
})

-- Strip Trailing Whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*' },
  group = augroup('strip_trailing_whitespace'),
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
  group = augroup('terminal_insert'),
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
  group = augroup('enable_relative_number'),
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
  group = augroup('disable_relative_number'),
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
  desc = 'Disable relative number',
})

vim.api.nvim_create_autocmd('VimResized', {
  pattern = { '*' },
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
  desc = 'Automatically Resize Windows Equally',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*' },
  group = augroup('rename_auto_backup_files'),
  callback = function()
    vim.cmd([[let &bex = strftime("📅%F⏰%X") .. '✍️']])
  end,
  desc = 'Rename backup files',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup('kitty_auto_reload'),
  pattern = { '*/kitty/*.conf' },
  callback = function()
    -- auto-reload kitty upon kitty.conf write
    -- https://github.com/kovidgoyal/kitty/discussions/5416#discussioncomment-3473122
    vim.cmd([[:silent !pgrep -i kitty | xargs kill -SIGUSR1]])
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = augroup('auto_lint'),
  callback = function()
    require('lint').try_lint()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude_filetype = { 'gitcommit' }

    local buf = event.buf
    if vim.tbl_contains(exclude_filetype, vim.bo[buf].filetype) or vim.b[buf].pde_last_loc then
      return
    end

    vim.b[buf].pde_last_loc = true

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('man_unlisted'),
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
