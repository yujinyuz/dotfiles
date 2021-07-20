local telescope = require('telescope')
local actions = require('telescope.actions')

-- Change mappings because of memory muscle from fzf
local mappings = {
  -- horizontal split
  -- next | prev
  ['j'] = false,
  ['k'] = false,
  ['<C-j>'] = actions.move_selection_next,
  ['<C-k>'] = actions.move_selection_previous,

  ['<Esc>'] = actions.close,
  ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,

  ['<C-s>'] = actions.select_horizontal,
  ['<C-x>'] = actions.select_horizontal,
  ['<C-v>'] = actions.select_vertical,
  ['<C-t>'] = actions.select_tab,
}

telescope.setup({
  defaults = {
    mappings = { i = mappings, n = mappings },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case',
    },
  },
})

telescope.load_extension('fzf')
