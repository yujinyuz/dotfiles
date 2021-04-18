--                  _  _
--                 (_)(_)
--    _   _  _   _  _  _  _ __   _   _  _   _  ____
--   | | | || | | || || || '_ \ | | | || | | ||_  /
--   | |_| || |_| || || || | | || |_| || |_| | / /
--    \__, | \__,_|| ||_||_| |_| \__, | \__,_|/___|
--     __/ |      _/ |            __/ |
--    |___/      |__/            |___/
--
--    Author: yujinyuz
--    GitHub: https://github.com/yujinyuz
--    Repository URL: https://github.com/yujinyuz/dotfiles
--    Desc: Collection of dotfiles gathered across different dotfiles repos

vim.g.mapleader = ' '
vim.g.python3_host_prog = os.getenv('PYTHON_3_HOST_PROG')
vim.g.grvubox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = 0
vim.g.indent_blankline_enabled = false
vim.g.gitblame_enabled = 0
vim.g.gruvbox_material_better_performance = 1

-- require('jyz.globals')

-- Load neovim options
require('modules.options')

-- :h vim.schedule
vim.schedule(function()
  -- Load packer.nvim config
  require('modules.plugins')
  -- LSP configuration
  require('modules.lsp')
  -- Telescope
  require('modules.telescope')
end)
