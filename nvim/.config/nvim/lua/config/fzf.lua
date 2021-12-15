local path = require('fzf-lua.path')
local fzf = require('fzf-lua')

fzf.setup({
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
    ['border'] = { 'bg', 'Normal' },
  },
  keymap = {
    builtin = {
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
    },
  },
  hl = {
    normal = 'TelescopePromptNormal',
    border = 'TelescopeBorder',
  },
  files = {
    git_icons = false,
  },
  git = {
    files = {
      cmd = 'git ls-files --exclude-standard --cached --others --deduplicate',
      git_icons = false,
    },
  },
  grep = {
    rg_opts = string.format('%s %s', fzf.config.globals.grep.rg_opts, '--hidden -g "!.git"'),
    git_icons = false,
  },
})

vim.keymap.nnoremap({
  '<leader>]',
  function()
    fzf.tags({ fzf_cli_args = '--nth=2..' })
  end,
})

vim.keymap.nnoremap({
  '<leader>F',
  function()
    fzf.live_grep({ fzf_cli_args = '--nth=2..' })
  end,
})
vim.keymap.nnoremap({
  '<leader>n',
  function()
    if path.is_git_repo(vim.fn.getcwd(), true) then
      fzf.git_files()
      return
    end
    fzf.files()
  end,
})
vim.keymap.nnoremap({ '<leader>bb', '<Cmd>FzfLua buffers<CR>' })
