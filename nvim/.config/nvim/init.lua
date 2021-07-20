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
end, 0)
