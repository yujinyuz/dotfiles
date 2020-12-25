:lua << EOF
local actions = require("telescope.actions")
local mappings = {
  -- horizontal split
  -- next | prev
  ["j"] = false,
  ["k"] = false,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  -- use esc for exit in normal mode
  ["<esc>"] = actions.close
}

require("telescope").setup {
  defaults = {
    mappings = {
      i = mappings,
      n = mappings
    }
  }
}
EOF

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>] <cmd>Telescope tags<cr>
nnoremap <leader><Space> <cmd>Telescope git_files<cr>
nnoremap <leader>F <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

