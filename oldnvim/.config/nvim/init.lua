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
--    @description Collection of dotfiles gathered across different dotfiles repos

-- Load globals
require('globals')
-- Load global helpers
require('utils')
-- Faster (?) startup time
prequire('impatient')
prequire('packer_compiled')
-- Load options
require('options')
-- Load plugins last
require('plugins')
