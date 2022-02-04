local fzf = require('fzf-lua')

fzf.setup {
  winopts = {
    height = 0.85, -- window height
    width = 0.80, -- window width
    row = 0.35, -- window row position (0=top, 1=bottom)
    col = 0.50, -- window col position (0=left, 1=right)
    hl = {
      normal = 'TelescopePromptNormal',
      border = 'TelescopeBorder',
      cursor = 'Cursor', -- cursor highlight (grep/LSP matches)
      cursorline = 'CursorLine', -- cursor line
      search = 'Search', -- search matches (ctags)
      -- title       = 'Normal',        -- preview border title (file/buffer)
    },

    preview = {
      delay = 0.1,
    },
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
    rg_opts = string.format('%s %s', fzf.config.globals.grep.rg_opts, '--hidden -g "!.git"'),
    git_icons = false,
    file_icons = false,
    multiprocess = true,
  },
  file_icon_padding = '',
  on_create = function()
    vim.keymap.set('t', '<Esc>', '<C-c>', { buffer = 0 })
  end,
}

if vim.env.NVIM_FILE_FINDER ~= 'fzf' then
  return
end

vim.keymap.set('n', '<leader>]', function()
  fzf.tags { fzf_cli_args = '--with-nth=2,1 --no-hscroll', winopts = { preview = { hidden = 'nohidden' } } }
end)

vim.keymap.set('n', '<leader>F', function()
  fzf.live_grep_native {
    fzf_cli_args = '--nth=2..',
    exec_empty_query = true,
    winopts = { preview = { hidden = 'nohidden' } },
  }
end)
vim.keymap.set('n', '<leader>n', function()
  -- local prompt = [[ProjectFiles> ]]
  local winopts = { preview = { hidden = 'hidden' } }

  -- if path.is_git_repo(vim.loop.cwd(), true) then
  --   fzf.git_files({
  --     fzf_opts = { ['--ansi'] = false },
  --     file_icons = false,
  --     git_icons = false,
  --     prompt = prompt,
  --     winopts = winopts,
  --   })
  --   return
  -- end
  fzf.files {
    fzf_opts = { ['--ansi'] = false },
    file_icons = false,
    git_icons = false,
    -- prompt = prompt,
    winopts = winopts,
  }
end)

vim.keymap.set('n', '<leader>bb', '<Cmd>FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>fw', '<Cmd>FzfLua grep_cword<CR>')
vim.keymap.set('n', 'gr', '<Cmd>FzfLua lsp_references<CR>')

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
