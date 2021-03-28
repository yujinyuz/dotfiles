local telescope = require('telescope')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

local nnoremap = vim.keymap.nnoremap
local cmd = require('modules.lib.nvim_helpers').cmd_map

-- Change mappings  because of memory muscle from fzf
local mappings = {
  -- horizontal split
  -- next | prev
  ['j'] = false,
  ['k'] = false,
  ['<C-j>'] = actions.move_selection_next,
  ['<C-k>'] = actions.move_selection_previous,
  -- use esc for exit in normal mode
  ['<Esc>'] = actions.close,
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
    },
  }
}

telescope.load_extension('fzy_native')

nnoremap { '<C-p>', cmd [[lua require('modules.telescope.support').find_files()]] }
nnoremap { '<leader>]', cmd [[lua require('modules.telescope.support').ctags()]] }
nnoremap { '<leader><Space>', cmd [[lua require('modules.telescope.support').git_files()]] }
nnoremap { '<leader>F', cmd [[lua require('modules.telescope.support').live_grep()]] }
nnoremap { '<leader>fw', cmd [[lua require('modules.telescope.support').grep_prompt()]] }
nnoremap { '<leader>b', cmd [[Telescope buffers]] }
nnoremap { '<leader>gw', cmd [[Telescope grep_string]] }
nnoremap { '<leader>en', cmd [[lua require('modules.telescope.support').edit_neovim()]] }
nnoremap { '<leader>of', cmd [[Telescope oldfiles]] }
