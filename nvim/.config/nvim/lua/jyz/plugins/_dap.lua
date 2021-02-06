local helpers = require('jyz.lib.nvim_helpers')
require('dap')
require('dap-python').setup('~/.local/share/virtualenvs/nvim/bin/python')


helpers.create_mappings{
  n = {
    {lhs = '<F5>', rhs = helpers.cmd_map([[lua require'dap'.continue()]]), opts = {silent = true, noremap = true}},
    {lhs = '<leader>db', rhs = helpers.cmd_map([[lua require'dap'.toggle_breakpoint()]]), opts = {silent = true, noremap = true}},
    {lhs = '<leader>dr', rhs = helpers.cmd_map([[lua require'dap'.repl.open()]]), opts = {silent = true, noremap = true}},
    {lhs = '<F10>', rhs = helpers.cmd_map([[lua require'dap'.step_over()]]), opts = {silent = true, noremap = true}},
  }
}
