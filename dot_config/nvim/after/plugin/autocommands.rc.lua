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
  callback = function(event)
    local ft = vim.bo[event.buf].filetype
    local buflisted = vim.bo[event.buf].buflisted

    if not buflisted then
      return
    end

    if ft:match('commit') or ft:match('rebase') then
      return
    end

    local winview = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(winview)
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
    if vim.g.muggle_friendly_mode then
      return
    end

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
    if vim.g.muggle_friendly_mode then
      return
    end

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
    local current_win = vim.api.nvim_get_current_win()

    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)

    -- Needed to prevent the cursor from moving somewhere else when resizing splits
    vim.api.nvim_set_current_win(current_win)
  end,
  desc = 'Automatically Resize Windows Equally',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*' },
  group = augroup('rename_auto_backup_files'),
  callback = function(event)
    if not vim.bo[event.buf].buflisted then
      return
    end
    vim.cmd([[let &bex = '±' .. strftime("%F∴%H:%M") .. '~']])
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

      -- if we jumped to a fold, open it
      if vim.fn.foldclosed(mark[1]) ~= -1 then
        print('fold was closed.. opening it')
        vim.cmd('normal! zvzz')
      end
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
    'grug-far',
    'fugitive',
    'fugitiveblame',
    'fugitive://*',
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

-- Enable spell for gitcommit and markdown
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('enable_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Enable htmldjango for html files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('enable_htmldjango'),
  pattern = { 'html' },
  callback = function(event)
    -- We should probably check first if we are inside a django project
    if
      #vim.fs.find('manage.py', { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(event.buf)) }) == 0
    then
      return
    end

    vim.bo[event.buf].filetype = 'htmldjango'
  end,
})

if vim.fn.executable('chezmoi') == 1 then
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = augroup('chezmoi_auto_apply'),
    pattern = { vim.fs.normalize('~/Sources/github.com/yujinyuz/dotfiles/*') },
    callback = function(event)
      local bufname = vim.fn.pathshorten(vim.api.nvim_buf_get_name(event.buf))

      vim.uv.spawn('chezmoi', {
        args = {
          'apply',
          '--force',
        },
      }, function(code, signal)
        vim.schedule(function()
          if vim.o.columns < 80 then
            return
          end
          local msg = string.format('applied %s code: %s, signal: %s', bufname, code, signal)
          require('my.utils').info(msg, '[chezmoi]')
        end)
      end)
    end,
  })
end

vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('relative_path_fix'),
  pattern = { '*' },
  callback = function()
    -- Sometimes buffer names become absolute paths and that messes up the
    -- name in the tabline.
    vim.cmd.lcd('.')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('man_toc_reminder'),
  pattern = { 'man' },
  callback = function()
    vim.api.nvim_echo({ { 'Press gO to toggle table of contents', 'DiagnosticInfo' } }, true, {})
  end,
  desc = 'Reminder to press gO to toggle table of contents',
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufWritePost' }, {
  group = augroup('bufsize'),
  pattern = '*',
  callback = function(event)
    local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(event.buf))
    local size_threshold = 5000 * 1024 -- 5mb

    if not stats then
      vim.b.bufsize = 0
    else
      vim.b.bufsize = stats.size
    end

    vim.b.bufsize_human = require('my.utils').humanize_size(vim.b.bufsize)

    if vim.b.bufsize > size_threshold then
      vim.b.large_buf = true
    else
      vim.b.large_buf = false
    end
  end,
  desc = 'Set buffer size and large_buf flag',
})

vim.api.nvim_create_autocmd('CursorMoved', {
  group = augroup('auto_hlsearch'),
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end
  end,
  desc = 'Automatically clear hlsearch when cursor moves',
})

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  group = augroup('term_color_sync'),
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end

    if vim.env.TMUX then
      io.write(string.format('\027Ptmux;\027\027]11;#%06x\007\027\\', normal.bg))
    else
      io.write(string.format('\027]11;#%06x\027\\', normal.bg))
    end
  end,
  desc = 'Automatically sync colorscheme with terminal',
})

vim.api.nvim_create_autocmd('UILeave', {
  group = augroup('term_color_unsync'),
  callback = function()
    if vim.env.TMUX then
      io.write('\027Ptmux;\027\027]111;\007\027\\')
    else
      io.write('\027]111\027\\')
    end
  end,
  desc = 'Automatically sync colorscheme with terminal',
})

vim.api.nvim_create_autocmd('TabNew', {
  group = augroup('overhead'),
  callback = function()
    if #vim.api.nvim_list_tabpages() > 2 then
      require('my.utils').warn('Hard to procses more than 2 tabs', '[brain]')
    end
  end,
  desc = 'Prevent overhead with multiple tabs',
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup('has_last_session'),
  callback = function()
    local file = require('persistence').current()

    if vim.o.columns < 80 then
      return
    end

    if vim.fn.filereadable(file) ~= 0 then
      require('my.utils').info('existing session found for this project', '[reminder]')
    end
  end,
})
