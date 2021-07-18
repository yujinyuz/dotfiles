local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'
local xnoremap = vim.keymap.xnoremap

local utils = require('utils')

require('lir').setup {
  border = 'single',
  show_hidden_files = true,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<CR>'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h']     = actions.up,
    ['-']     = actions.up,
    ['q']     = actions.quit,

    ['K']     = actions.mkdir,
    ['N']     = actions.newfile,
    ['R']     = actions.rename,
    ['@']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['I']     = actions.toggle_show_hidden,
    ['D']     = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 10,
  },
  hide_cursor = false,
}

-- use visual mode
function _G.lirsettings()
  -- vim.cmd [[setlocal nu rnu]]
  vim.opt_local.number = true
  vim.opt_local.relativenumber = true
  xnoremap {'J', function() require('lir.mark.actions').toggle_mark('v') end, silent = true, buffer = true}
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd filetype lir :lua lirsettings()]]
vim.cmd [[augroup end]]


-- utils.nnoremap('<leader>.', function() require('lir.float').toggle() end)
-- utils.nnoremap('<leader>/', function() require('lir.float').toggle('.') end)
