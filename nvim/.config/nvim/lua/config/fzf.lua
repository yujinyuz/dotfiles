local path = require('fzf-lua.path')
local fzf = require('fzf-lua')

fzf.setup({
  -- winopts = {
  --   preview = {
  --     default = 'bat_native',
  --   },
  -- },
  hl = {
    normal = 'TelescopePromptNormal',
    border = 'TelescopeBorder',
  },
  -- files = {
  --   git_icons = false,
  --   file_icons = false,
  -- },
  -- tags = {
  --   git_icons = false,
  --   file_icons = false,
  -- },
  git = {
    files = {
      prompt = 'GitFiles❯ ',
      cmd = 'git ls-files --exclude-standard --cached --others --deduplicate',
      -- git_icons = false, -- show git icons?
      -- file_icons = true, -- show file icons?
      -- color_icons = true, -- colorize file|git icons
    },
  },
  grep = {
    rg_opts = string.format('%s %s', fzf.config.globals.grep.rg_opts, '--hidden'),
  },
})

-- vim.keymap.nnoremap({ '<leader>]', '<Cmd>FzfLua tags<CR>' })
vim.keymap.nnoremap({
  '<leader>]',
  function()
    fzf.tags({ fzf_cli_args = '--nth=3..' })
  end,
})
-- vim.keymap.nnoremap({ '<leader>n', '<Cmd>FzfLua files<CR>' })
vim.keymap.nnoremap({ '<leader>F', '<Cmd>FzfLua live_grep_resume<CR>' })
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
