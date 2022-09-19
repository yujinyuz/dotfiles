vim.g.workbench_border = 'single'
vim.g.workbench_storage_path = vim.fn.expand('~/Sync/notes/workbench/')

local has_workbench, workbench = pcall(require, 'workbench')
if not has_workbench then
  return
end

-- vim.api.nvim_set_hl(0, 'WorkbenchWinFloatBorder', { bg = 'NONE', fg = 'red' })
-- vim.api.nvim_set_hl(0, 'WorkbenchWinNormalFloat', { bg = 'NONE' })

vim.keymap.set('n', '<leader>pp', function()
  workbench.toggle_project_workbench()
end, { silent = true, desc = 'Project Workbench' })
vim.keymap.set('n', '<leader>pb', function()
  workbench.toggle_branch_workbench()
end, { silent = true, desc = 'Project Workbench' })
