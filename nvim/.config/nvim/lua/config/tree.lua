vim.g.nvim_tree_ignore = {
  '.git',
  'node_modules',
}
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ':~'
vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }

-- default will show icon by default if no icon is provided
-- default shows no icon by default
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = '★',
  },
}

require('nvim-tree').setup({
  view = {
    width = 30,
    side = 'left',
  },
  updated_cwd = false,
  update_focused_file = {
    enable = true,
    updated_cwd = false,
  },
})
