local ts_configs = require("nvim-treesitter.configs")
ts_configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "fish",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsonc",
    "latex",
    "lua",
    "nix",
    "python",
    "regex",
    "rust",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vue",
    "yaml",
    -- "json",
    -- "markdown",
  },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = false },
  context_commentstring = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<M-w>',
      node_incremental = '<M-w>',
      scope_incremental = '<M-e>',
      node_decremental = '<M-C-w>',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = true, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["gD"] = "@function.outer",
      },
    },
  },
})





-- local M = {}

-- local text_objects = {
  --   select = {
    --     enable = true,
    --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    --     keymaps = {
      --       ['af'] = '@function.outer',
      --       ['if'] = '@function.inner',
      --       ['ac'] = '@class.outer',
      --       ['ic'] = '@class.inner',
      --     }
      --   },
      --   -- taken from mjlback/defaults.nvim
      --   move = {
        --     enable = true,
        --     set_jumps = true,
        --     goto_next_start = {
          --       [']m'] = '@function.outer',
          --       [']]'] = '@class.outer',
          --     },
          --     goto_next_end = {
            --       [']M'] = '@function.outer',
            --       [']['] = '@class.outer',
            --     },
            --     goto_previous_start = {
              --       ['[m'] = '@function.outer',
              --       ['[['] = '@class.outer',
              --     },
              --     goto_previous_end = {
                --       ['[M'] = '@function.outer',
                --       ['[]'] = '@class.outer',
                --     },
                --   },
                --   swap = {
                  --     enable = true,
                  --     swap_next = {
                    --       ['<leader>>'] = '@parameter.inner',
                    --     },
                    --     swap_previous = {
                      --       ['<leader><'] = '@parameter.outer',
                      --     }
                      --   }
                      -- }

                      -- local refactor = {
                        --   highlight_definitions = {enable = false},
                        --   highlight_current_scope = {enable = false},
                        --   smart_rename = {
                          --     enable = true,
                          --     keymaps = {
                            --       smart_rename = '<leader>rn',
                            --     },
                            --   },
                            -- }

                            -- local context_commentstring = {
                              --   enable = true,
                              -- }
                              -- local autopairs = {
                                --   enable = true,
                                -- }

                                -- M.setup = function ()
                                  --   local ts_configs = require('nvim-treesitter.configs')
                                  --   ts_configs.setup {
                                    --     ensure_installed = 'maintained',
                                    --     ignore_install = {
                                      --       'ql',
                                      --       'ledger',
                                      --       'c_sharp',
                                      --     },
                                      --     highlight = {
                                        --       enable = true,
                                        --       disable = {'json'},
                                        --       use_languagetree = true,
                                        --     },
                                        --     indent = {
                                          --       enable = true,
                                          --       disable = {'python'}
                                          --     },
                                          --     text_objects = text_objects,
                                          --     incremental_selection = {
                                            --       enable = true,
                                            --       keymaps = {
                                              --         init_selection = '<M-w>',
                                              --         node_incremental = '<M-w>',
                                              --         scope_incremental = '<M-e>',
                                              --         node_decremental = '<M-C-w>',
                                              --       }
                                              --     },
                                              --   }
                                              -- end

                                              -- return M
