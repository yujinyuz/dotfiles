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

require('utils')
require('options')

vim.defer_fn(function()
  require('plugins')

  -- TODO: Figure this out later
  -- I don't know why this does not work on my packer.nvim

  -- use({
  --   "nvim-treesitter/nvim-treesitter",
  --   run = ":TSUpdate",
  --   opt = true,
  --   event = "BufRead",
  --   requires = {
  --     { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
  --     "nvim-treesitter/nvim-treesitter-textobjects",
  --   },
  --   config = [[require('config.treesitter')]],

  -- I have to make it as a non-opt plugin and load the treesitter config
  require('config.treesitter')
end, 0)
