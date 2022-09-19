local has_fzf, fzf = pcall(require, 'fzf-lua')

if not has_fzf then
  return
end

local actions = require('fzf-lua.actions')

fzf.setup {
  actions = {
    files = {
      ['default'] = actions.file_edit,
      ['ctrl-x'] = actions.file_split,
      ['ctrl-v'] = actions.file_vsplit,
      ['ctrl-t'] = actions.file_tabedit,
      ['alt-q'] = actions.file_sel_to_qf,
    },
    buffers = {
      ['default'] = actions.buf_edit,
      ['ctrl-x'] = actions.buf_split,
      ['ctrl-v'] = actions.buf_vsplit,
      ['ctrl-t'] = actions.buf_tabedit,
    },
  },
  winopts = {
    hl = {
      normal = 'TelescopePromptNormal',
      border = 'TelescopeBorder',
      cursor = 'Cursor', -- cursor highlight (grep/LSP matches)
      cursorline = 'CursorLine', -- cursor line
      search = 'Search', -- search matches (ctags)
    },
    preview = {
      delay = 25,
    },
    height = 0.50,
    width = 0.68,
  },
  fzf_opts = {
    ['--border'] = 'none',
  },
  fzf_colors = {
    ['fg'] = { 'fg', 'CursorLine' },
    ['bg'] = { 'bg', 'Normal' },
    ['hl'] = { 'fg', 'Comment' },
    ['fg+'] = { 'fg', 'Normal' },
    ['bg+'] = { 'bg', 'CursorLine' },
    ['hl+'] = { 'fg', 'Statement' },
    ['info'] = { 'fg', 'PreProc' },
    ['prompt'] = { 'fg', 'Conditional' },
    ['pointer'] = { 'fg', 'Exception' },
    ['marker'] = { 'fg', 'Keyword' },
    ['spinner'] = { 'fg', 'Label' },
    ['header'] = { 'fg', 'Comment' },
    ['gutter'] = { 'bg', 'Normal' },
  },
  keymap = {
    builtin = {
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
      ['<C-h>'] = 'toggle-preview',
    },
  },
  files = {
    cmd = 'fd --strip-cwd-prefix --color=never --type f --hidden --follow --exclude .git',
    git_icons = false,
    multiprocess = true,
  },
  git = {
    files = {
      cmd = 'git ls-files --exclude-standard --cached --others --deduplicate',
      git_icons = false,
      file_icons = false,
      multiprocess = true,
    },
  },
  grep = {
    git_icons = false,
    file_icons = false,
    multiprocess = true,
  },
  file_icon_padding = '',
  lsp = {
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Compatibility-with-other-plugins
    async_or_timeout = 3000,
  },
  on_create = function()
    vim.keymap.set('t', '<Esc>', '<C-c>', { buffer = 0 })
  end,
}

if vim.env.NVIM_FILE_FINDER ~= 'fzf' then
  return
end

vim.keymap.set('n', '<leader>]', function()
  fzf.tags {
    fzf_cli_args = '--with-nth=2,1 --no-hscroll',
    winopts = { preview = { hidden = 'nohidden' } },
    file_icons = false,
    git_icons = false,
  }
end, {})

vim.keymap.set('n', '<leader>\\', function()
  fzf.lsp_live_workspace_symbols {
    fzf_cli_args = '--with-nth 2,1 --no-hscroll',
    file_icons = false,
    git_icons = false,
  }
end, {})

vim.keymap.set('n', '<leader>F', function()
  fzf.live_grep_glob { winopts = { preview = { hidden = 'hidden' } }, exec_empty_query = true }
end, {})
vim.keymap.set('n', '<leader>n', function()
  local winopts = {
    preview = { hidden = 'hidden' },
  }

  fzf.files {
    fzf_opts = { ['--ansi'] = false, ['--cycle'] = '' },
    file_icons = false,
    git_icons = false,
    winopts = winopts,
  }
end, { desc = 'Find Files' })

-- vim.keymap.set('n', '<leader>n', '<Cmd>CommandTRipgrep<CR>', {})
-- vim.keymap.set('n', '<leader>n', '<Cmd>CommandT<CR>', {})
-- vim.keymap.set('n', '<Leader>n', '<Plug>(CommandT)', {})

vim.keymap.set('n', '<leader>bb', '<Cmd>FzfLua buffers<CR>', {})
vim.keymap.set('n', '<leader>fw', '<Cmd>FzfLua grep_cword<CR>', {})
vim.keymap.set('n', 'gr', '<Cmd>FzfLua lsp_references<CR>', {})

if vim.loop.cwd() == vim.fn.expand('~/Sync/notes') then
  -- Override default bindings when we are inside our notes dir
  vim.keymap.set('n', '<leader>n', function()
    fzf.files {
      fzf_opts = { ['--tac'] = '', ['--no-sort'] = '' }, -- Sort reversed
      file_icons = false,
      git_icons = false,
    }
  end, {})
end
