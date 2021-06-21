-- NOTE: This file was named support.lua because it's supposed
-- to act like a support like in the parts of a telescope.
local M = {}

function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = '~ dotfiles ~',
    prompt_prefix = ' 🔍',
    shorten_path = false,
    cwd = "~/.config/nvim",
    follow = true,
    width = .25,

    layout_strategy = 'horizontal',
    layout_config = {preview_width = 0.65},
  }
end

function M.find_files()
  -- require('telescope').extensions.fzf_writer.files {}
  require('telescope.builtin').find_files {}

end

function M.live_grep()
  -- local opts = themes.get_dropdown {
  --   file_previewer = previewers.cat.new,
  --   grep_previewer = previewers.vimgrep.new,
  --   winblend = 10,
  --   border = true,
  --   shorten_path = true,
  -- }
  local opts = {shorten_path = false, only_sort_text = true}
  -- require('telescope').extensions.fzf_writer.staged_grep(opts)
  require('telescope.builtin').live_grep(opts)
end

function M.ctags()
  -- require('telescope').extensions.fzf_writer.tags {}
  -- local opts = themes.get_dropdown {
  --   winblend = 10,
  --   border = true,
  --   previewer = false,
  --   shorten_path = false,
  -- }
  -- local opts = {
  --   prompt = 'Tags',
  -- }

  require('telescope.builtin').tags {
    prompt_title = 'Tags',
    only_sort_tags = true,
  }
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    shorten_path = false,
    search = vim.fn.input('Grep String> '),
  }
end

return setmetatable(
  {}, {
    __index = function(_, k)
      -- reloader()

      if M[k] then
        return M[k]
      else
        return require('telescope.builtin')[k]
      end
    end,
  }
)
