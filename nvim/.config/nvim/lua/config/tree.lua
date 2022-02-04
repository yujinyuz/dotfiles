vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }
vim.g.nvim_tree_highlight_opened_files = 1

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

require('nvim-tree').setup {
  -- Fix the lir/nvim-tree issue
  update_to_buf_dir = {
    enable = false,
    auto_open = true,
  },
  ignore_ft_on_setup = { 'git' },
  filters = {
    dotfiles = false,
    custom = {},
  },
  view = {
    width = 30,
    side = 'left',
  },
  update_cwd = false,
  update_focused_file = {
    enable = true,
    updated_cwd = false,
  },
}
