--                  _  _
--                 (_)(_)
--    _   _  _   _  _  _  _ __   _   _  _   _  ____
--   | | | || | | || || || '_ \ | | | || | | ||_  /
--   | |_| || |_| || || || | | || |_| || |_| | / /
--    \__, | \__,_|| ||_||_| |_| \__, | \__,_|/___|
--     __/ |      _/ |            __/ |
--    |___/      |__/            |___/
--
--    @author yujinyuz
--    @gitHub https://github.com/yujinyuz
--    @repository https://github.com/yujinyuz/dotfiles
--    @descriptionn Collection of dotfiles gathered across different dotfiles repos

-- Make vim.keymap available
require('utils._keymap_port')
-- Load global helpers
require('utils')
-- Load options
require('options')

-- Since we have packer_compiled.lua, we don't need to load this immediately
vim.defer_fn(function()
  require('plugins')
end, 0)
