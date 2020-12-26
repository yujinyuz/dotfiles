local ts_configs = require('nvim-treesitter.configs')

local options = {
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
}

ts_configs.setup(options)
