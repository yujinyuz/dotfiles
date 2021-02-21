local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')

local nnoremap = vim.keymap.nnoremap
local cmd = require('jyz.lib.nvim_helpers').cmd_map

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
    },
  }
}

local M = {}

function M.edit_neovim()
  builtin.find_files {
    prompt_title = "~ dotfiles ~",
    prompt_prefix = ' 🔍',
    shorten_path = false,
    cwd = "~/.config/nvim",
    width = .25,

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    }
  }
end

function M.find_files()
  require('telescope').extensions.fzf_writer.files{}
end

function M.live_grep()
  -- local opts = themes.get_dropdown {
  --   file_previewer = previewers.cat.new,
  --   grep_previewer = previewers.vimgrep.new,
  --   winblend = 10,
  --   border = true,
  --   shorten_path = true,
  -- }
  local opts = {
    shorten_path = false,
  }
  -- require('telescope').extensions.fzf_writer.staged_grep(opts)
  require('telescope.builtin').live_grep(opts)
end

function M.ctags()
  -- require('telescope').extensions.fzf_writer.tags {}
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = true,
  }

  require('telescope.builtin').tags(opts)
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    shorten_path = false,
    search = vim.fn.input("Grep String> "),
  }
end


telescope.load_extension('fzy_native')


nnoremap { '<C-p>', [[<Cmd>lua require('jyz.telescope').find_files()<CR>]] }
nnoremap { '<leader>]', [[<Cmd>lua require('jyz.telescope').ctags()<CR>]] }
nnoremap { '<leader><Space>', [[<Cmd>lua require('jyz.telescope').git_files()<CR>]] }
nnoremap { '<leader>F', cmd [[lua require('jyz.telescope').live_grep()]] }
nnoremap { '<leader>fw', [[lua require('jyz.telescope').grep_prompt()]] }
nnoremap { '<leader>b', '<Cmd>Telescope buffers<CR>' }
nnoremap { '<leader>gw', '<Cmd>Telescope grep_string<CR>' }
nnoremap { '<leader>en', [[<Cmd>lua require('jyz.telescope').edit_neovim()<CR>]] }
nnoremap { '<leader>of', '<Cmd>Telescope oldfiles<CR>' }

return setmetatable({}, {
  __index = function(_, k)
    -- reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
