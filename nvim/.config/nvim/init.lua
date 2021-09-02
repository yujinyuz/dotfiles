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


-- Load globals
require('globals')
-- Make `vim.keymap` available
require('utils._keymap_port')
-- Load global helpers
require('utils')
-- Load options
require('options')
-- Load plugins last
require('plugins')

-- Faster (?) startup time
require('impatient')
