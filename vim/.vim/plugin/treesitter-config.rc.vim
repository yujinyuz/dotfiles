:lua << EOF
local custom_captures = {
  -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
  ['foo.bar'] = 'Identifier',
  ['function.call'] = 'LuaFunctionCall',
  ['function.bracket'] = 'Type',
}

require "nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
  highlight = {
    enable = true,
    disable = {"json"},
    use_languagetree = false,
  },
 indent = {
    enable = true
 },
 custom_captures = custom_captures
}
EOF
