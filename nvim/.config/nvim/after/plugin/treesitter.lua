require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  ignore_install = {
    'ql',
    'ledger',
    'c_sharp',
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<M-w>',
      node_incremental = '<M-w>',
      scope_incremental = '<M-e>',
      node_decremental = '<M-C-w>',
    }
  },
  highlight = {
    enable = true,
    disable = {'json'},
    use_languagetree = false,
  },
  indent = {
    enable = true,
    disable = {'python'}
  },
  refactor = {
    highlight_definitions = {enable = false},
    highlight_current_scope = {enable = false},
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = '<leader>rn',
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
    -- taken from mjlback/defaults.nvim
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>>'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader><'] = '@parameter.outer',
      }
    }
  },
  context_commentstring = {
    enable = true,
  },
  autopairs = {
    enable = true,
  }
}
