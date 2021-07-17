local nmap = vim.keymap.nmap
local vmap = vim.keymap.vmap

require('kommentary.config').configure_language(
  'default', {prefer_single_line_comments = true}
)
-- nmap {'<C-_>', '<Plug>kommentary_line_default'}
-- vmap {'<C-_>', '<Plug>kommentary_visual_default'}
