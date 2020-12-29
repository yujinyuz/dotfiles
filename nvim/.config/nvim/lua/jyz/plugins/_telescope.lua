local telescope = require('telescope')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local helpers = require('jyz.lib.nvim_helpers')

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

helpers.create_mappings{
  n = {
    {lhs = '<C-p>', rhs = helpers.cmd_map('Telescope find_files'), opts = {noremap = true, silent = true}},
    {lhs = '<leader>]', rhs = helpers.cmd_map('Telescope tags'), opts = {noremap = true, silent = true}},
    {lhs = '<leader><Space>', rhs = helpers.cmd_map('Telescope git_files'), opts = {noremap = true, silent = true}},
    {lhs = '<leader>F', rhs = helpers.cmd_map('Telescope live_grep'), opts = {noremap = true, silent = true}},
    {lhs = '<leader>b', rhs = helpers.cmd_map('Telescope buffers'), opts = {noremap = true, silent = true}},
    {lhs = '<leader>gw', rhs = helpers.cmd_map('Telescope grep_string'), opts = {noremap = true, silent = true}},
  }
}
