local helpers = require('jyz.lib.nvim_helpers')
local shell = os.getenv('SHELL')

helpers.create_mappings{
  n = {
    -- Write file when it is updated
    {lhs = '<leader>w', rhs = helpers.cmd_map('update'), opts = {silent = true, noremap = true}},
    -- Quit all
    {lhs = '<leader>qa', rhs = helpers.cmd_map('qa!'), opts = {silent = true, noremap = true}},
    -- Quit current
    {lhs = '<leader>qq', rhs = helpers.cmd_map('q!'), opts = {silent = true, noremap = true}},
    -- Blackhole delete
    {lhs = '<leader>d', rhs = '"_d', opts = {silent = true, noremap = true}},
    {lhs = 'Q', rhs = 'gq', opts = {noremap = true}},
    -- Remove highlights
    {lhs = '<C-l>', rhs = [[:nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>]], opts = {noremap = true, silent = true}},
    -- Make Y work like other upcase commands
    {lhs = 'Y', rhs = 'y$', opts = {noremap = true}},
    -- Buffer Switch
    {lhs = '<BS>', rhs = '<C-^>', opts = {noremap = true}},
    -- Resize splits with arrows
    {lhs = '<Up>', rhs = '<C-w>+', opts = {noremap = true}},
    {lhs = '<Down>', rhs = '<C-w>-', opts = {noremap = true}},
    {lhs = '<Left>', rhs = '<C-w><', opts = {noremap = true}},
    {lhs = '<Right>', rhs = '<C-w>>', opts = {noremap = true}},
    {lhs = '<leader>=', rhs = '<C-w>=', opts = {noremap = true}},
    -- Smooth scroll
    {lhs = '<C-y>', rhs = '3<C-y>', opts = {noremap = true}},
    {lhs = '<C-e>', rhs = '3<C-e>', opts = {noremap = true}},
    -- Use Alt for moving lines up/down
    {lhs = '<M-j>', rhs = [[mz:m+<CR>`z]], opts = {noremap = true, silent = true}},
    {lhs = '<M-k>', rhs = [[mz:m-2<CR>`z]], opts = {noremap = true, silent = true}},
    -- Create new file relative to the currently opened file
    {lhs = '<leader>fn', rhs = [[:e %:h<C-z>]], opts = {noremap = true}},
    -- Save and execute
    {lhs = '<leader>x', rhs = helpers.cmd_map([[lua require('jyz.lib.nvim_helpers').save_and_execute()]]), opts = {noremap = true, silent = true}},
    -- Open new terminal
    {lhs = '<leader>ot', rhs = helpers.cmd_map([[rightbelow split<CR><Cmd>exec "resize " . (winheight(0) * 2/3)<CR><Cmd>e term://]] .. shell), opts = {noremap = true, silent = true}},
  },
  i = {
    -- Make it easier when navigating through pums
    {lhs = '<C-j>', rhs = '<C-n>', opts = {noremap = true}},
    {lhs = '<C-k>', rhs = '<C-p>', opts = {noremap = true}},
  },
  c = {
    -- Command-line like navigation
    {lhs = '<C-k>', rhs = '<Up>', opts = {noremap = true}},
    {lhs = '<C-j>', rhs = '<Down>', opts = {noremap = true}},
  },
  x = {
    -- Don't lose selection when shifting sidewards
    {lhs = '<', rhs = '<gv', opts = {noremap = true}},
    {lhs = '>', rhs = '>gv', opts = {noremap = true}},
  },
  v = {
    -- Use alt for moving lines or selected lines up/down
    {lhs = '<M-j>', rhs = [[:m'>+<CR>`<my`>mzgv`yo`z]], opts = {noremap = true, silent = true}},
    {lhs = '<M-k>', rhs = [[:m'<-2<CR>`>my`<mzgv`yo`z]], opts = {noremap = true, silent = true}},
  },
  t = {
    {lhs = '<Esc>', rhs = [[<C-\><C-n>]], opts = {noremap = true}},
    {lhs = '<M-h>', rhs = [[<C-\><C-n><C-w>h]], opts = {noremap = true}},
    {lhs = '<M-j>', rhs = [[<C-\><C-n><C-w>j]], opts = {noremap = true}},
    {lhs = '<M-k>', rhs = [[<C-\><C-n><C-w>k]], opts = {noremap = true}},
    {lhs = '<M-l>', rhs = [[<C-\><C-n><C-w>l]], opts = {noremap = true}},
  }
}
