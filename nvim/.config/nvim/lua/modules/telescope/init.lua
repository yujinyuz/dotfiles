local telescope = require('telescope')
local actions = require('telescope.actions')

local nnoremap = vim.keymap.nnoremap

local trouble = require('trouble.providers.telescope')

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
  ['<C-i>'] = trouble.open_with_trouble,
  ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,

  ['<C-s>'] = actions.select_horizontal,
  ['<C-x>'] = actions.select_horizontal,
  ['<C-v>'] = actions.select_vertical,
  ['<C-t>'] = actions.select_tab,

}

telescope.setup {
  defaults = {
    mappings = {i = mappings, n = mappings},
  },
  extensions = {
    fzf = {
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case',
    },
  },
}

-- telescope.load_extension('fzy_native')
telescope.load_extension('fzf')


nnoremap {'<C-p>', function() require('modules.telescope.support').find_files() end}
nnoremap {'<leader>]', function() require('modules.telescope.support').ctags() end}
-- nnoremap {'<leader><Space>', function() require('modules.telescope.support').git_files() end}
-- nnoremap {'<leader>F', function() require('modules.telescope.support').live_grep() end}
nnoremap {'<leader>fw', function() require('modules.telescope.support').grep_prompt() end}
nnoremap {'<leader>b', function() require('telescope.builtin').buffers() end}
nnoremap {'<leader>gw', function() require('telescope.builtin').grep_string() end}

nnoremap {'<leader>en', function() require('modules.telescope.support').edit_neovim() end}
nnoremap {'<leader>fo', function() require('telescope.builtin').oldfiles() end}
