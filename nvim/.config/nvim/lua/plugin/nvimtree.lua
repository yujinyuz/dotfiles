local nnoremap = vim.keymap.nnoremap

local cmd = require('jyz.lib.nvim_helpers').cmd_map
local augroup = require('jyz.lib.nvim_helpers').augroup


vim.g.nvim_tree_side = 'left'
vim.g.nvim_tree_width = 30
vim.g.nvim_tree_ignore = {
  '.git', 'node_modules', '__sapper__', '.routify', 'dist', '.cache'
}
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ':~'
vim.g.nvim_tree_tab_open = 0
vim.g.nvim_tree_show_icons = {git = 0, folders = 1, files = 1}

-- default will show icon by default if no icon is provided
-- default shows no icon by default
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★"
  },
}

nnoremap { '<C-n>', cmd 'NvimTreeToggle' }


augroup('LuaTreeCallback', {
    {
      events = {'FileType'},
      targets = {'LuaTree'},
      command = [[setlocal nowrap cursorline signcolumn=no]]

    };
})
