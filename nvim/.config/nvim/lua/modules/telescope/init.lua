local telescope = require('telescope')
local actions = require('telescope.actions')

local nnoremap = vim.keymap.nnoremap
local cmd = require('modules.lib.nvim_helpers').cmd_map

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

nnoremap {
  '<C-p>',
  cmd [[lua require('modules.telescope.support').find_files()]],
}
nnoremap {'<leader>]', cmd [[lua require('modules.telescope.support').ctags()]]}
nnoremap {
  '<leader><Space>',
  cmd [[lua require('modules.telescope.support').git_files()]],
}
nnoremap {
  '<leader>F',
  cmd [[lua require('modules.telescope.support').live_grep()]],
}
nnoremap {
  '<leader>fw',
  cmd [[lua require('modules.telescope.support').grep_prompt()]],
}
nnoremap {'<leader>b', cmd [[Telescope buffers]]}
nnoremap {'<leader>gw', cmd [[Telescope grep_string]]}
nnoremap {
  '<leader>en',
  cmd [[lua require('modules.telescope.support').edit_neovim()]],
}
nnoremap {'<leader>fo', cmd [[Telescope oldfiles]]}
