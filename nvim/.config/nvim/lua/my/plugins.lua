local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  print('Downloading lazy.nvim...')
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  --block: Core Editing
  -- syntax, indentation,
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead' },
    config = function()
      require('configs.treesitter')
    end,
    build = function()
      -- pcall is similar to a try/catch block so that our config doesn't throw any errors
      -- in case installing tree-sitter objects fails
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
      { 'windwp/nvim-ts-autotag' },
      { 'RRethy/nvim-treesitter-endwise' },
      { 'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor' },
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = 'VeryLazy',
        config = function()
          require('ts_context_commentstring').setup {
            enable_autocmd = false,
          }
        end,
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    config = function()
      require('configs.cmp')
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'lukas-reineke/cmp-rg',
      'lukas-reineke/cmp-under-comparator',
      'neovim/nvim-lspconfig',
      'chrisgrieser/cmp_yanky',
      {
        'zbirenbaum/copilot-cmp',
        config = true,
        dependencies = {
          'zbirenbaum/copilot.lua',
          opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
          },
        },
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim', 'markdown' },
      map_c_w = true,
      check_ts = true,
    },
  },
  {
    'echasnovski/mini.comment',
    event = { 'BufReadPost', 'BufNewFile' },
    version = false,
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPost', 'BufNewFile' },
    version = false,
    init = function()
      vim.g.miniindentscope_disable = true
    end,
    config = function()
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
      }
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPost', 'BufNewFile' },
    version = false,
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },

  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
  { 'tpope/vim-rsi', event = 'VeryLazy' },
  { 'tpope/vim-abolish', event = 'VeryLazy' },
  {
    'mbbill/undotree',
    init = function()
      vim.g.undotree_HighlightChangedWithSign = 0
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
    keys = {
      { '<leader>u', '<Cmd>UndotreeToggle<CR>', desc = 'Undotree Toggle' },
    },
    cmd = { 'UndotreeToggle' },
  },
  {
    'kevinhwang91/nvim-fundo',
    requires = 'kevinhwang91/promise-async',
    config = function()
      require('fundo').install()
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    keys = {
      {
        '<leader>S',
        function()
          require('spectre').open()
        end,
        desc = 'Search and Replace',
      },
      {
        '<leader>sw',
        function()
          require('spectre').open_visual { select_word = true }
        end,
        desc = 'Search and Replace',
      },
      {
        '<leader>sp',
        function()
          vim.cmd([[normal! viw]])
          require('spectre').open_file_search()
        end,
        desc = 'Search and Replace',
      },
    },
  },
  {
    'andymass/vim-matchup',
    event = 'VeryLazy',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  { 'tversteeg/registers.nvim', event = 'VeryLazy' },
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>j', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    'gbprod/yanky.nvim',
    keys = { 'y', '<Left>', '<Right>', '<leader>yy' },
    config = function()
      require('yanky').setup {
        ring = {
          history_length = 100,
          storage = 'shada',
          sync_with_numbered_registers = true,
          cancel_event = 'update',
          ignore_registers = { '_' },
          update_register_on_cycle = false,
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        preserve_cursor_position = {
          enabled = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
      }

      vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

      vim.keymap.set('n', '<leader>yy', '<Cmd>YankyRingHistory<CR>')

      -- The unimpaired y feels awkard to press when using colemak layout
      vim.keymap.set('n', '[y', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', ']y', '<Plug>(YankyNextEntry)')
      vim.keymap.set('n', '<Left>', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', '<Right>', '<Plug>(YankyNextEntry)')
    end,
  },
  --endblock: Core Editing

  --block: Navigation/File Management
  {
    'ibhagwan/fzf-lua',
    keys = {
      { '<leader>n', desc = 'Fi[n]d files' },
      { '<leader>]', desc = 'Tags' },
      { '<leader>F', desc = '[F]ind text' },
    },
    config = function()
      require('configs.fzf')
    end,
  },
  {
    'tpope/vim-eunuch',
    cmd = { 'Delete', 'Move', 'Rename' },
  },
  {
    'ludovicchabant/vim-gutentags',
    event = 'VeryLazy',
    init = function()
      vim.g.gutentags_project_root = { '.croot' }
      vim.g.gutentags_define_advanced_commands = true
      vim.g.gutentags_add_default_project_roots = false
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      hijack_directories = {
        enable = false,
      },
      select_prompts = true,
    },
    keys = {
      { '<C-n>', '<Cmd>NvimTreeFindFileToggle!<CR>', desc = '[n]vim-tree toggle' },
    },
  },
  {
    'stevearc/oil.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        view_options = {
          show_hidden = false,
        },
        win_options = {
          wrap = false,
          signcolumn = 'no',
          cursorcolumn = false,
          foldcolumn = '0',
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = 'ncv',
        },
        keymaps = {
          ['<C-c>'] = false,
          ['<leader>qq'] = 'actions.close',
          ['<C-l>'] = false,
          ['<C-r>'] = 'actions.refresh',
          ['y.'] = 'actions.copy_entry_path',
        },
        skip_confirm_for_simple_edits = true,
      }
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    keys = {
      { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    cmd = { 'AerialToggle' },
    keys = {
      { '\\t', '<cmd>AerialToggle<cr>', desc = '' },
    },
  },
  { 'kevinhwang91/nvim-bqf' },
  {
    'otavioschwanck/arrow.nvim',
    keys = { '<leader>;' },
    opts = {
      show_icons = true,
      leader_key = '<leader>;',
      separate_by_branch = true,
    },
  },
  --endblock: Navigation

  --block: Integration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('configs.lspconfig')
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        build = ':MasonToolsInstall',
        config = function()
          require('mason-tool-installer').setup {
            ensure_installed = {
              'prettierd',
              'eslint_d',
              'black',
              'djlint',
              'codespell',
              'cspell',
              'stylua',
              'fixjson',
              'ruff',
              'hadolint',
              'write-good',
            },
          }
        end,
      },
    },
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
    keys = {
      {
        '<C-l>',
        function()
          require('luasnip').expand()
        end,
        mode = 'i',
      },
    },
    -- build = 'make install_jsregexp',
    dependencies = 'rafamadriz/friendly-snippets',
  },
  { 'folke/neodev.nvim' },
  { 'folke/neoconf.nvim' },
  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'eslint_d' },
        python = { { 'ruff', 'black' }, 'reorder-python-imports' },
        fish = { 'fish_indent' },
        json = { 'jq' },
        jsonc = { 'fixjson' },
        htmldjango = { 'djlint' },
      },
      format_on_save = function(bufnr)
        if not require('my.format').auto_format then
          return
        end

        -- Check if there is a .disable-autoformat file in the root of the project
        local disable_autoformat = not vim.tbl_isempty(
          vim.fs.find('.disable-autofmt', { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) })
        )
        if disable_autoformat then
          return
        end

        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        fish = { 'fish' },
        python = { 'ruff' },
        dockerfile = { 'hadolint' },
        htmldjango = { 'djlint' },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git', 'G', 'Gvdiffsplit' },
    keys = {
      { '<leader>gs', '<Cmd>Git<CR>', desc = 'Git' },
      { '<leader>gv', '<Cmd>Gvdiffsplit<CR>', desc = 'Git' },
    },
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<Cmd>Neogit<CR>', desc = 'Neogit' },
    },
    opts = {
      kind = 'split_above',
      integrations = { diffview = true },
      disable_commit_confirmation = true,
      sections = {
        untracked = {
          folded = true,
        },
      },
      mappings = {
        status = {
          ['='] = 'Toggle',
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    {
      'ruifm/gitlinker.nvim',
      config = true,
      keys = {
        { '<leader>gy', mode = { 'n', 'v' } },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      local gs = require('gitsigns')
      return {
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '_' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' },
        },
        signcolumn = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end

            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Next Hunk' })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end

            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Prev Hunk' })

          -- Actions
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk)
          vim.keymap.set('v', '<leader>hs', function()
            gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
          end)
          vim.keymap.set('v', '<leader>hr', function()
            gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
          end)
          vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
          vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
          vim.keymap.set('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end)

          -- Commented this out since it conflicts with some of my mappings that starts
          -- with <leader>t. Will come back to this later
          -- vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
          -- vim.keymap.set('n', '<leader>td', gs.toggle_deleted)
          vim.keymap.set('n', '<leader>hd', gs.diffthis)
          vim.keymap.set('n', '<leader>hD', function()
            gs.diffthis('~')
          end)
        end,
      }
    end,
  },
  --endblock: Integration

  --block: Fancy UI
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe',
        background = {
          light = 'latte',
          dark = 'frappe',
        },
        no_italic = true, -- Force  no italic
        no_bold = true, -- Force no bold
        term_colors = true,
        sytles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            GitpadFloat = { bg = colors.none },
            GitpadFloatBorder = { bg = colors.none },
            GitpadFloatTitle = { fg = colors.none, bg = colors.none },
            Folded = { bg = colors.surface1 }, -- Fix folded background when using transparent
            BqfPreviewFloat = { bg = colors.none },
            BqfPreviewBorder = { bg = colors.none },
            BqfPreviewTitle = { bg = colors.none, fg = colors.none },
            BqfPreviewThumb = { bg = colors.none },
          }
        end,
        integrations = {
          aerial = true,
          cmp = true,
          mason = true,
          nvimtree = true,
          which_key = true,
          fidget = true,
          rainbow_delimiters = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
      }
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require('which-key')
      wk.setup {
        show_help = false,
        key_labels = {
          ['<leader>'] = 'SPC',
          ['<CR>'] = 'RET',
          ['<TAB>'] = 'TAB',
        },
        window = { padding = { 0, 0, 0, 0 } },
        layout = { height = { min = 1, max = 10 } },
        triggers_blacklist = {
          c = { 'w' },
          n = { '`' },
        },
      }
      wk.register {
        ['<leader>c'] = { name = '+lsp' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>h'] = { name = '+hunk' },
        ['<leader>p'] = { name = '+pad' },
        ['<leader>q'] = { name = '+quit' },
        ['<leader>s'] = { name = '+search' },
        ['y'] = { name = '+yank' },
        ['yo'] = { name = '+switch on/off' },
      }
    end,
  },
  { 'onsails/lspkind-nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  {
    'echasnovski/mini.statusline',
    version = false,
    config = function()
      require('my.statusline')
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = { 'BufRead' },
    opts = {
      -- Copied from catppuccin theme recommendation
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
      require('rainbow-delimiters.setup').setup {}
    end,
  },
  -- {
  --   'levouh/tint.nvim',
  --   opts = {
  --     tint = -5,
  --     saturation = 0.0,
  --   },
  -- },
  {
    'miversen33/sunglasses.nvim',
    event = 'UIEnter',
    opts = {
      filter_type = 'NOSYNTAX',
      filter_percent = 0.45,
    },
  },
  --endblock: Fancy UI

  --block: Filetype Specific
  {
    'SidOfc/mkdx',
    ft = 'markdown',
    init = function()
      local settings = {
        -- Use GitHub supported toggles
        checkbox = {
          toggles = { ' ', 'x' },
        },
        enter = {
          shift = 1,
        },
      }
      vim.g['mkdx#settings'] = settings
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'drmingdrmer/vim-indent-lua', ft = 'lua' },
  { 'michaeljsmith/vim-indent-object', ft = 'python' },
  { 'martinda/Jenkinsfile-vim-syntax', ft = { 'groovy', 'Jenkinsfile' } },
  { 'thecodesmith/vim-groovy', ft = 'groovy' },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'NoahTheDuke/vim-just', ft = 'just' },
  { 'cuducos/yaml.nvim', ft = { 'yaml' } },
  --endblock: Filetype Specific

  --block: Miscellaneous
  {
    'danymat/neogen',
    cmd = { 'Neogen' },
    opts = {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'reST',
          },
        },
      },
    },
  },
  {
    'tpope/vim-scriptease',
    cmd = { 'Scriptnames', 'Messages', 'Verbose' },
    keys = { 'zS' },
  },
  {
    'numToStr/FTerm.nvim',
    keys = {
      {
        '<M-i>',
        function()
          require('FTerm').toggle()
        end,
        mode = 'n',
      },
      {
        '<M-i>',
        function()
          vim.fn.feedkeys('<C-\\><C-n>')
          -- FIXME: Can't use vim.cmd.normal at the moment
          -- See issue: https://github.com/neovim/neovim/issues/4895
          -- vim.cmd.normal {'<C-\\><C-n>', bang = true }
          require('FTerm').toggle()
        end,
        mode = 't',
      },
    },
  },
  {
    'yujinyuz/gitpad.nvim',
    dev = true,
    config = function()
      require('gitpad').setup {
        dir = '~/Sync/notes/gitpad',
        border = 'rounded',
        on_attach = function()
          vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>silent! wq<CR>', { noremap = true, silent = true })
          vim.opt_local.textwidth = 100
        end,
      }
    end,
    keys = {
      {
        '<leader>pp',
        function()
          require('gitpad').toggle_git_pad()
        end,
        desc = 'gitpad',
      },
      {
        '<leader>pb',
        function()
          require('gitpad').toggle_git_pad_branch()
        end,
        desc = 'gitpad branch',
      },
    },
  },
  {
    'letieu/hacker.nvim',
    dev = true,
    config = function()
      vim.keymap.set('n', '<leader>ha', ':autocmd!<CR><Cmd>HackFollow<CR>', { silent = true })
      local function fixfile()
        vim.fn.execute('normal! ggdG')
        vim.fn.execute('read ' .. vim.fn.expand('%') .. '.hackertyper')
        vim.fn.execute('normal! ggdd')
        vim.fn.execute('write!')
      end

      vim.keymap.set('n', '<leader>fix', fixfile, { silent = true })
    end,
  },
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', desc = 'Make it rain' },
    },
  },
  --endblock: Miscellaneous
}

local _ = {
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        compile = false,
        globalStatus = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            LazyNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
            WhichKeyFloat = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },

            GitpadFloatBorder = { bg = 'none', fg = theme.ui.float.fg_border },
            GitpadFloatTitle = { bg = 'none', fg = theme.ui.special },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- Since kanagawa.nvim doesn't implement these, then we just have to define it here
            TelescopeNormal = { fg = theme.ui.fg, bg = theme.ui.bg },
            TelescopeSelection = { fg = theme.ui.fg, bg = theme.ui.bg_p2 },
          }
        end,
      }

      if vim.o.background == 'light' then
        vim.cmd.colorscheme('kanagawa-lotus')
      else
        vim.cmd.colorscheme('kanagawa')
      end
    end,
  },
}

require('lazy').setup(plugins, {
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'zipPlugin',
      },
    },
  },
  dev = {
    path = '~/Sources/github.com/yujinyuz',
  },
})

-- vim:foldmethod=marker:foldlevel=0:foldmarker=--block,--endblock
