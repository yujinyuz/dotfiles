return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufNewFile', 'BufReadPost', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall' },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'css',
        'diff',
        'fennel',
        'fish',
        'git_config',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'gitattributes',
        'glimmer', -- handlebars
        'go',
        'gotmpl',
        'html',
        'htmldjango',
        'javascript',
        'latex',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'nix',
        'python',
        'regex',
        'ruby',
        'rust',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
        -- 'comment',
        -- 'json',
        -- 'jsonc',
      },
      highlight = {
        enable = true,
        disable = function(lang, bufnr)
          return vim.b.large_buf
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
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
        lint_events = { 'BufWrite', 'CursorHold' },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = 'Select around function' },
            ['if'] = { query = '@function.inner', desc = 'Select inside function' },
            ['ac'] = { query = '@class.outer', desc = 'Select around class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inside class' },

            ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
            ['i='] = { query = '@assignment.inner', desc = 'Select inside part of an assignment' },

            -- ['=l'] = { query = '@assignment.lhs', desc = 'Select left-hand side of assignment' },
            -- ['=r'] = { query = '@assignment.rhs', desc = 'Select right-hand side of assignment' },

            ['lhs'] = { query = '@assignment.lhs', desc = 'Select left-hand side of assignment' },
            ['rhs'] = { query = '@assignment.rhs', desc = 'Select right-hand side of assignment' },

            ['aa'] = { query = '@parameter.outer', desc = 'Select around parameter/argument' },
            ['ia'] = { query = '@parameter.inner', desc = 'Select inside parameter/argument' },

            ['ax'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
            ['ix'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
          goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
          goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
          goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
        },
        swap = {
          enable = true,
          swap_next = { ['<leader>>'] = '@parameter.inner' },
          swap_previous = { ['<leader><'] = '@parameter.outer' },
        },
        lsp_interop = {
          enable = true,
          peek_definition_code = {
            ['gD'] = '@function.outer',
          },
        },
      },
      refactor = {
        navigation = {
          enable = true,
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = '<leader>rn',
          },
        },
      },
      autopairs = { enable = true },
      endwise = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.schedule(function()
        local ts_info = require('nvim-treesitter.info')
        vim.api.nvim_create_autocmd('FileType', {
          pattern = ts_info.installed_parsers(),
          callback = function()
            vim.opt_local.foldmethod = 'expr'
            vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end,
          desc = 'Set foldexpr for treesitter parsers',
        })
      end)
    end,
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'RRethy/nvim-treesitter-endwise' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'folke/ts-comments.nvim',
    opts = {
      lang = {
        htmldjango = {
          '{# %s #}',
        },
      },
    },
  },
}
