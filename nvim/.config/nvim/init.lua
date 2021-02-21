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


-- require('jyz.globals')

-- Load neovim options
require('jyz.options')

-- Defer loading
vim.schedule(function()
  -- Load packer.nvim config
  require('jyz.plugins')
  -- LSP configuration
  require('jyz.lsp')
  -- Telescope
  require('jyz.telescope')
end)
