local nnoremap = vim.keymap.nnoremap
vim.g.workbench_border = 'single'

nnoremap {
  '<leader>pp',
  function() require('workbench').toggle_project_workbench() end,
}

nnoremap {
  '<leader>pb',
  function() require('workbench').toggle_branch_workbench() end,
}
