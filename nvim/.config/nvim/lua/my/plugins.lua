local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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
  -- Prereq packages {{{
  { 'nvim-lua/popup.nvim' },
  { 'nvim-lua/plenary.nvim' },
  -- }}}

  -- LSP {{{
  {
    'neovim/nvim-lspconfig',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('configs.lspconfig')
    end,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('configs.null-ls')
        end,
      },
      'folke/neodev.nvim',
    },
  },
  {
    'glepnir/lspsaga.nvim',
    cmd = { 'Lspsaga' },
    opts = {
      code_action_lightbulb = {
        sign = false,
      },
    },
    version = '*',
  },
  --- }}}

  -- Ease of editing {{{
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
      { 'yioneko/nvim-yati' }, -- For indentation
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
      { 'HiPhish/nvim-ts-rainbow2' },
      { 'windwp/nvim-ts-autotag' },
      { 'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor' },
    },
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufRead' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
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
    },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim', 'markdown', 'neo-tree-popup' },
      map_c_w = true,
      check_ts = true,
    },
  },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired', event = { 'BufEnter' } },
  { 'tpope/vim-rsi' },
  { 'tpope/vim-abolish', cmd = { 'Abolish' } },
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
  --- }}}

  -- File actions and navigations {{{
  {
    'ibhagwan/fzf-lua',
    keys = {
      { '<leader>n' },
      { '<leader>]' },
      { '<leader>F' },
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
    event = { 'BufRead' },
    init = function()
      vim.g.gutentags_project_root = { 'manage.py', 'pyrightconfig.json', 'init.lua' }
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
      { '<C-n>', '<Cmd>NvimTreeFindFileToggle!<CR>', desc = '[n]vim-tree toggle'},
    },
  },
  {
    'tamago324/lir.nvim',
    config = function()
      require('configs.lir')
    end,
    keys = {
      {
        '<leader>.',
        function()
          require('lir.float').toggle()
        end,
      },
      {
        '<leader>/',
        function()
          require('lir.float').toggle('.')
        end,
      },
    },
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = true,
    keys = {
      { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup {}
    end,
  },
  --- }}}

  --- Git {{{
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gs', '<Cmd>Git<CR>', desc = 'Git' },
      { '<leader>gv>', '<Cmd>Gvdiffsplit<CR>', desc = 'Fugitive Diffsplit' },
    },
    cmd = { 'Git', 'G', 'Gcd', 'Gwrite', 'Gvdiffsplit', 'Gdiffsplit' },
  },
  {
    'TimUntersberger/neogit',
    opts = {

      integrations = { diffview = true },
      disable_commit_confirmation = true,
    },
    cmd = { 'Neogit' },
    keys = {
      { '<leader>gg', '<Cmd>Neogit<CR>' },
    },
    dependencies = { 'sindrets/diffview.nvim' },
  },
  {
    'ruifm/gitlinker.nvim',
    config = true,
    keys = {
      { '<leader>gy' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
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
        end,
      }
    end,
  },
  --- }}}

  --- Fancy UI {{{
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        globalStatus = true,
        overrides = {
          FloatBorder = { bg = 'NONE' },
          NormalFloat = { bg = 'NONE' },
        },
      }
      vim.cmd.colorscheme('kanagawa')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = function()
      local navic = require('nvim-navic')
      return {
        options = {
          theme = 'auto',
          -- separator = '|',
          icons_enabled = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = {
            { navic.get_location, cond = navic.is_available },
            'encoding',
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
    dependencies = {
      {
        'SmiteshP/nvim-navic',
        keys = {
          {
            '<C-s>',
            function()
              print(require('nvim-navic').get_location())
            end,
            desc = 'Show current location',
          },
        },
      },
    },
  },
  {
    'kyazdani42/nvim-web-devicons',
    opts = {

      override = {
        lir_folder_icon = {
          icon = '',
          color = '#7ebae4',
          name = 'lirfoldernode',
        },
      },
      default = true,
    },
  },
  { 'onsails/lspkind-nvim' },
  {
    'lukas-reineke/indent-blankline.nvim',
    init = function()
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
    end,
    event = { 'BufRead' },
    opts = {
      enabled = false,
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
      space_char_blankline = ' ',
      char_highlight_list = {
        'IndentBlanklineIndent1',
        'IndentBlanklineIndent2',
        'IndentBlanklineIndent3',
        'IndentBlanklineIndent4',
        'IndentBlanklineIndent5',
        'IndentBlanklineIndent6',
      },
    },
  },
  { 'j-hui/fidget.nvim', event = { 'BufRead' }, opts = { text = { spinner = 'dots_footsteps' } } },
  -- { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
  --- }}}

  -- General ftplugin {{{
  { 'SidOfc/mkdx', ft = 'markdown' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'michaeljsmith/vim-indent-object', ft = 'python' },
  --- }}}

  -- Miscellaneous {{{
  {
    'danymat/neogen',
    cmd = { 'Neogen' },
    opts = {
      enabled = true,
    },
  },
  {
    'tpope/vim-scriptease',
    cmd = { 'Scriptnames', 'Messages', 'Verbose' },
    keys = { 'zS' },
  },
  { 'numToStr/FTerm.nvim' },
  {
    'akinsho/toggleterm.nvim',
    opts = {

      shell = vim.env.SHELL,
      shade_terminals = false,
      highlights = {
        Normal = {
          guibg = 'NONE',
        },
        NormalFloat = {
          link = 'Normal',
        },
      },
    },
  },
  {
    'weizheheng/nvim-workbench',
    init = function()
      vim.g.workbench_border = 'single'
      vim.g.workbench_storage_path = vim.fn.expand('~/Sync/notes/workbench/')
    end,
    keys = {
      {
        '<leader>pp',
        function()
          require('workbench').toggle_project_workbench()
        end,
        desc = 'Project Workbench',
      },
      {
        '<leader>pb',
        function()
          require('workbench').toggle_branch_workbench()
        end,
        desc = 'Branch Workbench',
      },
    },
  },
  { 'tversteeg/registers.nvim' },
  --- }}}
}

require('lazy').setup(plugins)

-- vim: foldmethod=marker foldlevel=0
