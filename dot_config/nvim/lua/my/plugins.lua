local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
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
  --block: Core Editing, syntax, indentation,
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
      'chrisgrieser/cmp_yanky',
      'yutkat/cmp-mocword',
      {
        'yujinyuz/cmp-async-path',
        dev = true,
      },
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
      disable_filetype = { 'vim', 'markdown' },
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
          return vim.b.commentstring_override
            or require('ts_context_commentstring.internal').calculate_commentstring()
            or vim.bo.commentstring
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
        draw = {
          delay = 10,
        },
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
          coco = { pattern = '%f[%w]()COCO()%f[%W]', group = 'Debug' },
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },

  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-unimpaired', keys = { 'yo', '[', ']' } },
  { 'tpope/vim-rsi', event = 'InsertEnter' },
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
  },
  {
    'kevinhwang91/nvim-fundo',
    event = { 'BufWritePre' },
    dependencies = { 'kevinhwang91/promise-async' },
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
    event = 'BufReadPost',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  { 'tversteeg/registers.nvim', event = 'VeryLazy' },
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    'gbprod/yanky.nvim',
    event = { 'BufReadPost' },
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
      vim.keymap.set('n', '<Left>', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', '<Right>', '<Plug>(YankyNextEntry)')
    end,
  },
  --endblock: Core Editing

  --block: Navigation/File Management
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
    'yujinyuz/mini.files',
    dev = true,
    version = false,
    init = function()
      vim.g.mini_files_auto_confirm_on_simple_edits = true
    end,
    opts = {
      options = {
        use_as_default_explorer = false,
      },
      mappings = {
        go_in_plus = '<CR>',
      },
    },
    keys = {
      {
        ',t',
        function()
          local mf = require('mini.files')
          if not mf.close() then
            mf.open(vim.api.nvim_buf_get_name(0))
            mf.reveal_cwd()
          end
        end,
      },
    },
  },
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    opts = {
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
        concealcursor = 'nvic',
      },
      keymaps = {
        ['<C-c>'] = false,
        ['q'] = 'actions.close',
        ['<C-l>'] = false,
        ['<C-r>'] = 'actions.refresh',
        ['y.'] = 'actions.copy_entry_path',
      },
      skip_confirm_for_simple_edits = true,
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
  {
    'otavioschwanck/arrow.nvim',
    keys = {
      { ',a', desc = '[a]rrow' },
    },
    opts = {
      show_icons = true,
      leader_key = ',a',
      separate_by_branch = true,
    },
  },
  --endblock: Navigation

  --block: Integration
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
  {
    'stevearc/conform.nvim',
    event = 'BufReadPost',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'eslint_d' },
        python = { { 'ruff_format', 'black' }, 'ruff_fix' },
        fish = { 'fish_indent' },
        json = { 'jq' },
        jsonc = { 'fixjson' },
        htmldjango = { 'djlint' },
        toml = { 'taplo' },
      },
      format_on_save = function(bufnr)
        if not require('my.format').is_enabled(bufnr) then
          return nil
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
        -- Used ruff
        -- python = { 'ruff' },
        dockerfile = { 'hadolint' },
        htmldjango = { 'djlint' },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { 'G', mode = 'c' },
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
  },
  {
    'ruifm/gitlinker.nvim',
    config = true,
    keys = {
      { '<leader>gy', mode = { 'n', 'v' } },
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
        no_italic = false, -- Force  no italic
        no_bold = false,
        term_colors = true,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            Folded = { bg = colors.surface1 }, -- Fix folded background when using transparent
            MiniStatuslineFilePrefix = { fg = colors.subtext0 },
            MiniStatuslineFilename = { fg = colors.text, style = { 'bold' } },
            MiniStatuslineDevinfo = { fg = colors.text },
            MiniStatuslineModeNormal = { fg = colors.mantle, bg = colors.blue, style = { 'bold' } },
            MiniStatuslineModeInsert = { fg = colors.base, bg = colors.green, style = { 'bold' } },
            MiniStatuslineModeVisual = { fg = colors.base, bg = colors.mauve, style = { 'bold' } },
            MiniStatuslineModeReplace = { fg = colors.base, bg = colors.red, style = { 'bold' } },
            MiniStatuslineModeCommand = { fg = colors.base, bg = colors.peach, style = { 'bold' } },
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
    event = 'VeryLazy',
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
          c = { 'w', 'f', 'F' },
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
  { 'kyazdani42/nvim-web-devicons', lazy = true },
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
    event = 'BufReadPost',
    config = function()
      local rainbow = require('rainbow-delimiters')
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = function(bufnr)
            -- Disabled for very large files, global strategy for large files,
            -- local strategy otherwise
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            if line_count > 10000 then
              return nil
            elseif line_count > 1000 then
              return rainbow.strategy['global']
            end
            return rainbow.strategy['local']
          end,
        },
      }
    end,
  },
  {
    'levouh/tint.nvim',
    event = 'VeryLazy',
    opts = {
      tint = -5,
      saturation = 0,
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
        local buflisted = vim.api.nvim_get_option_value('buflisted', { buf = bufid })
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ''
        local diff_mode = vim.api.nvim_get_option_value('diff', { win = winid })

        -- Do not tint unlisted buffers since we don't really care about them
        if not buflisted then
          return true
        end

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == 'terminal' or floating or diff_mode
      end,
    },
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        enabled = false,
      },
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
  { 'Vimjas/vim-python-pep8-indent', ft = 'python', enabled = false },
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
    config = function()
      local FTerm = require('FTerm')
      FTerm.setup {
        -- Makes things a little bit more stable with tmux since it
        -- does not inherit the environment variables
        clear_env = true,
      }

      local lazydocker = FTerm:new {
        ft = 'fterm_lazydocker',
        cmd = 'lazydocker',
        clear_nv = true,
      }

      vim.api.nvim_create_user_command('LazyDockerToggle', function()
        lazydocker:toggle()
      end, {})

      local fterm1 = FTerm:new {
        cmd = vim.env.SHELL,
        ft = 'fterm_1',
        clear_env = true,
      }

      local fterm2 = FTerm:new {
        cmd = vim.env.SHELL,
        ft = 'fterm_2',
        clear_env = true,
      }

      vim.api.nvim_create_user_command('FTermToggle', FTerm.toggle, { bang = true })
      vim.api.nvim_create_user_command('FTerm1Toggle', function()
        fterm1:toggle()
      end, { bang = true })

      vim.api.nvim_create_user_command('FTerm2Toggle', function()
        fterm2:toggle()
      end, { bang = true })

      vim.api.nvim_create_user_command('FTermCloseAllExcept', function(command)
        if command.args == '1' then
          FTerm.close()
          fterm2:close()
        elseif command.args == '2' then
          FTerm.close()
          fterm1:close()
        else
          fterm1:close()
          fterm2:close()
        end
      end, {
        complete = function()
          return { '0', '1', '2' }
        end,
        nargs = '?',
      })
    end,
    cmd = {
      'FTermToggle',
      'FTerm1Toggle',
      'FTerm2Toggle',
      'LazyDockerToggle',
    },
    keys = {
      {
        '<M-e>',
        function()
          if vim.fn.mode() == 't' then
            vim.cmd('FTermCloseAllExcept 0')
          end
          require('FTerm').toggle()
        end,
        mode = { 'n', 't' },
      },
      {
        '<M-i>',
        function()
          if vim.fn.mode() == 't' then
            vim.cmd('FTermCloseAllExcept 1')
          end
          vim.cmd('FTerm1Toggle')
        end,
        mode = { 'n', 't' },
      },
      {
        '<M-o>',
        function()
          if vim.fn.mode() == 't' then
            vim.cmd('FTermCloseAllExcept 2')
          end
          vim.cmd('FTerm2Toggle')
        end,
        mode = { 'n', 't' },
      },
      {
        '<M-a>',
        function()
          vim.cmd('LazyDockerToggle')
        end,
        mode = { 'n', 't' },
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
        on_attach = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<Cmd>silent! wq<CR>', { noremap = true, silent = true })
          vim.opt_local.textwidth = 100
        end,
      }
    end,
    keys = {
      {
        '<leader>pp',
        function()
          require('gitpad').toggle_gitpad()
        end,
        desc = 'gitpad project',
      },
      {
        '<leader>pb',
        function()
          require('gitpad').toggle_gitpad_branch()
        end,
        desc = 'gitpad branch',
      },
      {
        '<leader>pn',
        function()
          local date_filename = 'daily-' .. os.date('%Y-%m-%d.md')
          require('gitpad').toggle_gitpad { filename = date_filename, title = 'Daily Notes' }
        end,
        desc = 'gitpad daily notes',
      },
      {
        '<leader>pf',
        function()
          local filename = vim.fn.bufname()
          if filename == '' then
            vim.notify('empty bufname')
            return
          end
          filename = filename .. '.md'
          require('gitpad').toggle_gitpad { filename = filename }
        end,
        desc = 'gitpad per file notes',
      },
    },
  },
  {
    'letieu/hacker.nvim',
    dev = true,
    keys = {
      { '<leader>ha', ':autocmd!<CR><Cmd>HackFollow<CR>', silent = true },
    },
  },
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', desc = 'Make it rain' },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = { debug = true },
    keys = {
      {
        '<leader>cch',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.fzflua').pick(actions.help_actions())
        end,
        mode = { 'n', 'x' },
      },
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        mode = 'n',
      },
      {
        '<leader>ccp',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.fzflua').pick(actions.prompt_actions())
        end,
        mode = { 'n', 'x' },
      },
      {
        '<leader>cgc',
        '<Cmd>CopilotChatCommitStaged<CR>',
        mode = 'n',
      },
    },
  },
  {
    'shellRaining/hlchunk.nvim',
    keys = {
      {
        'yoH',
        function()
          local utils = require('my.utils')
          vim.b.hlchunk_t_state = not vim.b.hlchunk_t_state

          if vim.b.hlchunk_t_state then
            require('hlchunk.mods').chunk:enable()
            utils.info('enabled hlchunk', 'Toggle')
          else
            require('hlchunk.mods').chunk:disable()
            utils.warn('disabled hlchunk', 'Toggle')
          end
        end,
        desc = 'Toggle hlchunk',
      },
    },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = false,
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
      }
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {},
    keys = {
      {
        '<leader>xx',
        function()
          require('trouble').toggle()
        end,
        desc = 'Trouble Toggle',
      },
      {
        '<leader>xw',
        function()
          require('trouble').toggle('workspace_diagnostics')
        end,
      },
      {
        '<leader>xd',
        function()
          require('trouble').toggle('document_diagnostics')
        end,
      },
      {
        '<leader>xq',
        function()
          require('trouble').toggle('quickfix')
        end,
      },
      {
        '<leader>xl',
        function()
          require('trouble').toggle('loclist')
        end,
      },
      {
        'gR',
        function()
          require('trouble').toggle('lsp_references')
        end,
      },
    },
  },
  {
    'wakatime/vim-wakatime',
    event = 'BufReadPost',
  },
  {
    'yujinyuz/very-magic-slash.nvim',
    event = 'VeryLazy',
    opts = {},
    dev = true,
  },
  --endblock: Miscellaneous
}

require('lazy').setup {
  spec = {
    plugins,
    { import = 'my.specs' },
  },
  change_detection = {
    notify = false,
  },
  install = { colorscheme = { 'catppuccin', 'habamax' } },
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
}

-- vim:foldmethod=marker:foldlevel=0:foldmarker=--block,--endblock
