local has_lir, lir = pcall(require, 'lir')
if not has_lir then
  return
end

local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')

lir.setup {
  show_hidden_files = true,
  devicons = {
    enable = true,
  },
  mappings = {
    ['l'] = actions.edit,
    ['<CR>'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-x>'] = actions.split, -- Duplicated because of muscle memory
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h'] = actions.up,
    ['-'] = actions.up,
    ['q'] = actions.quit,

    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['I'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
    curdir_window = {
      enable = false,
      highlight_dirname = false,
    },
    win_opts = function()
      return {
        border = 'rounded',
      }
    end,
  },
  hide_cursor = false,
  on_init = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.keymap.set('x', 'J', function()
      mark_actions.toggle_mark('v')
    end, { silent = true, buffer = 0 })

    vim.keymap.set('n', 'X', function()
      actions.delete()
    end, { silent = true, buffer = 0 })
  end,
}
