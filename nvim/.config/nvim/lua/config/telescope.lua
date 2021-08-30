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

require('telescope').setup({
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = 'top',
    },

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

require('telescope').load_extension('fzf')

local M = {}

M.project_files = function(opts)
  opts = opts or {}

  local _ = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require('telescope.builtin').find_files(opts)
    return
  end

  require('telescope.builtin').git_files(opts)
end

M.live_grep = function(opts)
  opts = opts
    or {
      only_sort_text = true,
      vimgrep_arguments = {
        'rg',
        '--smart-case',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--hidden',
        '--glob=!.git' -- ignore .git folders when doing live grep
      },
    }

  require('telescope.builtin').live_grep(opts)
end

vim.keymap.nnoremap({ '<leader><Space>', M.project_files })
vim.keymap.nnoremap({ '<leader>F', M.live_grep })

return M
