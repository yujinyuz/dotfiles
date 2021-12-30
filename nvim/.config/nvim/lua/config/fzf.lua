local path = require('fzf-lua.path')
local fzf = require('fzf-lua')

fzf.setup({
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
    },
  },
  files = {
    git_icons = false,
    multiprocess = true,
  },
  git = {
    files = {
      cmd = 'git ls-files --exclude-standard --cached --others --deduplicate',
      previewer = { _ctor = false },
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
    vim.keymap.tnoremap({ '<Esc>', '<C-c>', buffer = true })
  end,
})

if vim.env.NVIM_FILE_FINDER ~= 'fzf' then
  return
end

vim.keymap.nnoremap({
  '<leader>]',
  function()
    fzf.tags({ fzf_cli_args = '--with-nth=2,1 --no-hscroll' })
  end,
})

vim.keymap.nnoremap({
  '<leader>F',
  function()
    fzf.live_grep({ fzf_cli_args = '--nth=2..', exec_empty_query = true })
  end,
})
vim.keymap.nnoremap({
  '<leader>n',
  function()
    if path.is_git_repo(vim.loop.cwd(), true) then
      fzf.git_files({ fzf_opts = { ['--ansi'] = false }, file_icons = false, git_icons = false })
      return
    end
    fzf.files({ fzf_opts = { ['--ansi'] = false }, file_icons = false, git_icons = false })
  end,
})
vim.keymap.nnoremap({ '<leader>bb', '<Cmd>FzfLua buffers<CR>' })
vim.keymap.nnoremap({ '<leader>fw', '<Cmd>FzfLua grep_cword<CR>' })
