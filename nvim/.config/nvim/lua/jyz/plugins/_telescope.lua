local telescope = require('telescope')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local helpers = require('jyz.lib.nvim_helpers')
local set_keymap = helpers.set_keymap

-- Change mappings  because of memory muscle from fzf
local mappings = {
  -- horizontal split
  -- next | prev
  ["j"] = false,
  ["k"] = false,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  -- use esc for exit in normal mode
  ["<esc>"] = actions.close,
}


telescope.setup {
  defaults = {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    mappings = {
      i = mappings,
      n = mappings
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}

telescope.load_extension('fzy_native')

set_keymap('n', '<C-p>', helpers.cmd_map('Telescope find_files'), {nowait = true, silent = true})
set_keymap('n', '<leader>]', helpers.cmd_map('Telescope tags'), {nowait = true, silent = true})
set_keymap('n', '<leader><Space>', helpers.cmd_map('Telescope git_files'), {nowait = true, silent = true})
set_keymap('n', '<leader>F', helpers.cmd_map('Telescope live_grep'), {nowait = true, silent = true})
set_keymap('n', '<leader>b', helpers.cmd_map('Telescope buffers'), {nowait = true, silent = true})
set_keymap('n', '<leader>gw', helpers.cmd_map('Telescope grep_string'), {nowait = true, silent = true})

