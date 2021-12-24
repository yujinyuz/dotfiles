local actions = require('telescope.actions')
local action_set = require('telescope.actions.set')
local previewers = require('telescope.previewers')

-- Change mappings because of memory muscle from fzf
local mappings = {
  -- horizontal split
  -- next | prev
  ['j'] = false,
  ['k'] = false,
  ['<C-j>'] = actions.move_selection_next,
  ['<C-k>'] = actions.move_selection_previous,

  ['<Esc>'] = actions.close,
  ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,

  ['<C-s>'] = actions.select_horizontal,
  ['<C-x>'] = actions.select_horizontal,
  ['<C-v>'] = actions.select_vertical,
  ['<C-t>'] = actions.select_tab,
}

local _bad = { '.*%.csv', '.*%.min.js' }
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then
    opts.use_ft_detect = true
  end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

local fixfolds = {
  hidden = true,
  attach_mappings = function(_)
    action_set.select:enhance({
      post = function()
        vim.cmd(':normal! zx')
      end,
    })
    return true
  end,
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
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    buffers = fixfolds,
    file_browser = fixfolds,
    find_files = fixfolds,
    git_files = fixfolds,
    grep_string = fixfolds,
    live_grep = fixfolds,
    oldfiles = fixfolds,
    tags = fixfolds,
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

  local ok = pcall(require('telescope.builtin').git_files, opts)

  if not ok then
    require('telescope.builtin').find_files(opts)
  end
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
        '--glob=!.git', -- ignore .git folders when doing live grep
      },
    }

  require('telescope.builtin').live_grep(opts)
end

if vim.env.NVIM_FILE_FINDER ~= 'telescope' then
  return
end

vim.keymap.nnoremap({ '<leader><Space>', M.project_files })
vim.keymap.nnoremap({ '<leader>oo', M.project_files })
vim.keymap.nnoremap({ '<leader>bb', require('telescope.builtin').buffers })
vim.keymap.nnoremap({ '<leader>F', M.live_grep })

return M
