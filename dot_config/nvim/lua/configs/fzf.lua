local has_fzf, fzf = pcall(require, 'fzf-lua')

if not has_fzf then
  return
end

local actions = require('fzf-lua.actions')
local defaults = require('fzf-lua.defaults').defaults

fzf.setup {
  'telescope',
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
    preview = {
      delay = 25,
    },
    height = 0.50,
    width = 0.68,
  },
  fzf_opts = {
    -- ['--border'] = 'none',
    -- ['--no-separator'] = '',
    ['--no-hscroll'] = '',
    ['--layout'] = 'reverse',
  },
  keymap = {
    builtin = {
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
      ['<C-h>'] = 'toggle-preview',
      ['<C-y>'] = 'toggle-preview-wrap',
      ['<C-b>'] = 'toggle-preview-cw',
    },
  },
  files = {
    fd_opts = '--strip-cwd-prefix ' .. defaults.files.fd_opts,
    git_icons = false,
    multiprocess = true,
  },
  git = {
    files = {
      cmd = defaults.git.files.cmd .. ' --cached --others --deduplicate',
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
  previewers = {
    builtin = {
      extensions = {
        ['png'] = { 'viu', '-b' },
        ['jpeg'] = { 'viu', '-b' },
        ['jpg'] = { 'viu', '-b' },
      },
    },
  },
  on_create = function()
    vim.keymap.set('t', '<Esc>', '<C-c>', { buffer = 0 })
  end,
}

-- Register fzf-lua as the picker for vim.ui.select()
fzf.register_ui_select()

if vim.env.NVIM_FILE_FINDER ~= 'fzf' then
  return
end

vim.keymap.set('n', '<leader>]', function()
  fzf.tags {
    winopts = { preview = { hidden = 'nohidden' } },
    file_icons = false,
    git_icons = false,
  }
end)

vim.keymap.set('n', '<leader>\\', function()
  fzf.lsp_live_workspace_symbols {}
end)

vim.keymap.set('n', '<leader>F', function()
  fzf.live_grep_glob { winopts = { preview = { hidden = 'hidden' } }, exec_empty_query = true }
end)
vim.keymap.set('n', '<leader>n', function()
  local winopts = {
    preview = { hidden = 'hidden' },
  }

  fzf.files {
    fzf_opts = { ['--cycle'] = '' },
    file_icons = false,
    git_icons = false,
    winopts = winopts,
  }
end, { desc = 'Find Files' })

vim.keymap.set('n', '<leader>bb', '<Cmd>FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>fw', '<Cmd>FzfLua grep_cword<CR>')
vim.keymap.set('n', 'gr', '<Cmd>FzfLua lsp_references<CR>')
vim.keymap.set('n', 'z=', '<Cmd>FzfLua spell_suggest<CR>')
vim.keymap.set('n', '<leader>gw', '<Cmd>FzfLua grep_cword<CR>')
vim.keymap.set('n', '<leader>?', '<Cmd>FzfLua lines<CR>')
vim.keymap.set('n', '<leader>N', '<Cmd>FzfLua resume<CR>')

vim.keymap.set('i', '<C-x><C-f>', function()
  require('fzf-lua').complete_path()
end, { silent = true, desc = 'Fuzzy complete path' })
if vim.loop.cwd() == vim.fn.expand('~/Sync/notes') then
  -- Override default bindings when we are inside our notes dir
  vim.keymap.set('n', '<leader>n', function()
    fzf.files {
      fzf_opts = { ['--tac'] = '', ['--no-sort'] = '' }, -- Sort reversed
      file_icons = false,
      git_icons = false,
    }
  end)
end
