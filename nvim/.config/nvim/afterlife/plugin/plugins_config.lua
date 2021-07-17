-- Here resides some config files that require minimal config
local nmap = vim.keymap.nmap
local nnoremap = vim.keymap.nnoremap
local tnoremap = vim.keymap.tnoremap

-- can use this for ref: https://github.com/wincent/wincent/blob/d6d64aaafc407ef31bd22878b93bef73087c1d82/aspects/vim/files/.config/nvim/plugin/autocomplete.lua

local cmd = require('modules.lib.nvim_helpers').cmd_map

-- vim-fugitive
nnoremap {'<leader>gs', cmd 'G'}
nnoremap {'<leader>gc', cmd 'G commit'}

nnoremap {'<leader>u', cmd 'UndotreeToggle'}

-- ferret
nmap {'<leader>fa', '<Plug>(FerretAck)'}

nnoremap {'<C-l>', ':nohlsearch<CR>', silent = true}
nnoremap {
  'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
}
nnoremap {
  'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
}
nnoremap {'*', [[*<Cmd>lua require('hlslens').start()<CR>]]}
nnoremap {'#', [[#<Cmd>lua require('hlslens').start()<CR>]]}
nnoremap {'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]]}
nnoremap {'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]]}

-- unimpaired overrides
nnoremap {'yol', function() require('indent_blankline.commands').toggle() end}
nnoremap {
  'yob',
  function()
    vim.cmd [[GitBlameToggle]]
    require('gitsigns').toggle_signs()
  end,
}
nnoremap {'<leader>gg', cmd 'Neogit'}

-- trouble.nvim
vim.api.nvim_set_keymap(
  'n', '<leader>xx', '<cmd>LspTroubleToggle<cr>',
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
  'n', '<leader>xw', '<cmd>LspTroubleToggle lsp_workspace_diagnostics<cr>',
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
  'n', '<leader>xd', '<cmd>LspTroubleToggle lsp_document_diagnostics<cr>',
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
  'n', '<leader>xl', '<cmd>LspTroubleToggle loclist<cr>',
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
  'n', '<leader>xq', '<cmd>LspTroubleToggle quickfix<cr>',
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
  'n', 'gR', '<cmd>LspTrouble lsp_references<cr>',
  {silent = true, noremap = true}
)

-- nvim-workbench

-- nvim-spectre
nnoremap {'<leader>S', function() require('spectre').open() end}

-- zen-mode.nvim
nnoremap {'<leader>2', function() require('zen-mode').toggle() end}
nnoremap {'<leader>3', function() require('twilight').toggle() end}

-- FTerm.nvim
nnoremap {'<leader>ot', function() require('FTerm').toggle() end}
tnoremap {'<leader>ot', function() require('FTerm').toggle() end}
-- alternatives
nnoremap {'<A-i>', function() require('FTerm').toggle() end}
tnoremap {'<A-i>', function() require('FTerm').toggle() end}

nnoremap {
  '<A-l>',
  function()
    vim.cmd [[read ~/.config/joplin-desktop/templates/Night Journal.md]]
    vim.cmd [[normal! gg]]
    vim.bo.filetype = 'markdown'
  end,
}
