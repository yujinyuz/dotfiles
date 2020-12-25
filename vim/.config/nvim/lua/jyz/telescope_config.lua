local telescope = require('telescope')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')

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


local nvim_set_keymap = vim.api.nvim_set_keymap


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

nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', {nowait = true, silent = true})
nvim_set_keymap('n', '<leader>]', '<cmd>Telescope tags<CR>', {nowait = true, silent = true})
nvim_set_keymap('n', '<leader><Space>', '<cmd>Telescope git_files<CR>', {nowait = true, silent = true})
nvim_set_keymap('n', '<leader>F', '<cmd>Telescope live_grep<CR>', {nowait = true, silent = true})
nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', {nowait = true, silent = true})
nvim_set_keymap('n', '<leader>gw', [[<cmd>Telescope grep_string<CR>]], {nowait = true, silent = true})
