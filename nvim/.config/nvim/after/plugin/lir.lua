local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'
local nnoremap = vim.keymap.nnoremap
local xnoremap = vim.keymap.xnoremap
local cmd = require('modules.lib.nvim_helpers').cmd_map

require'lir'.setup {
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
    size_percentage = 0.5,
    winblend = 10,
    border = false,
    borderchars = {"╔" , "═" , "╗" , "║" , "╝" , "═" , "╚", "║"},

    -- If you want to use `shadow`, set `shadow` to `true`.
    -- Also, if you set shadow to true, the value of `borderchars` will be ignored.
    shadow = true,
  },
  hide_cursor = false,
}

-- custom folder icon
require'nvim-web-devicons'.setup({
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "lirfoldernode"
    },
  }
})

-- use visual mode
function _G.lirsettings()
  -- vim.cmd [[setlocal nu rnu]]
  vim.opt_local.number = true
  vim.opt_local.relativenumber = true
  xnoremap {'J', cmd [[<C-u>lua require('lir.mark.actions').toggle_mark('v')]], silent = true, buffer = true}

  -- echo cwd
  vim.api.nvim_echo({{vim.fn.expand('%:p'), 'normal'}}, false, {})

end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd filetype lir :lua lirsettings()]]
vim.cmd [[augroup end]]


nnoremap { '<leader>.', cmd [[lua require('lir.float').toggle()]] }
nnoremap { '<leader>/', cmd [[lua require('lir.float').toggle('.')]] }
