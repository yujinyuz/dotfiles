require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>",
      node_incremental = "<M-w>",
      scope_incremental = "<M-e>",
      node_decremental = "<M-C-w>",
    }
  },
  highlight = {
    enable = true,
    disable = {"json"},
    use_languagetree = false,
  },
  indent = {
    enable = true,
    disable = {"python"}
  },
  refactor = {
    highlight_definitions = {enable = false},
    highlight_current_scope = {enable = false},
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>rn",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader><"] = "@parameter.outer",
      }
    }
  }
}

