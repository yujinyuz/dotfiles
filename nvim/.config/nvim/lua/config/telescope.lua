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
      -- preview_cutoff = 120,
      prompt_position = 'top',

      -- horizontal = {
      --   -- width_padding = 0.1,
      --   -- height_padding = 0.1,
      --   preview_width = function(_, cols, _)
      --     if cols > 200 then
      --       return math.floor(cols * 0.4)
      --     else
      --       return math.floor(cols * 0.6)
      --     end
      --   end,
      -- },

      -- vertical = {
      --   -- width_padding = 0.05,
      --   -- height_padding = 1,
      --   width = 0.9,
      --   height = 0.95,
      --   preview_height = 0.5,
      -- },

      -- flex = {
      --   horizontal = {
      --     preview_width = 0.9,
      --   },
      -- },
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
      },
    }

  require('telescope.builtin').live_grep(opts)
end

vim.keymap.nnoremap({ '<leader><Space>', M.project_files })
vim.keymap.nnoremap({ '<leader>F', M.live_grep })

return M
