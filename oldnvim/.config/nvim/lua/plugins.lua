local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  print('Downloading packer.nvim...')
  vim.fn.system(string.format('git clone %s %s --depth 1', 'https://github.com/wbthomason/packer.nvim', install_path))
  vim.cmd([[packadd packer.nvim]])
end

local packer = require('packer')

local plugins = function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  use { 'lewis6991/impatient.nvim' }

  use {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
  }

  -- LSP Stuffs
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
    requires = {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
      'folke/lua-dev.nvim',
    },
  }
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup {}
    end,
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    opt = true,
    module = 'mason-lspconfig',
  }

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('config.comments')
    end,
    requires = 'JoosepAlviste/nvim-ts-context-commentstring',
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup {
        text = {
          spinner = 'moon',
        },
        align = {
          bottom = true,
        },
      }
    end,
  }

  use {
    'danymat/neogen',
    opt = true,
    cmd = { 'Neogen' },
    config = function()
      require('neogen').setup {
        enabled = true,
      }
    end,
  }

  -- AST Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('config.treesitter')
    end,
    requires = {
      { 'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
      { 'p00f/nvim-ts-rainbow' },
      { 'RRethy/nvim-treesitter-textsubjects' },
      { 'windwp/nvim-ts-autotag' },
    },
  }
  use { 'ThePrimeagen/refactoring.nvim' }
  use {
    'SmiteshP/nvim-navic',
  }
  use { 'yioneko/nvim-yati' }

  -- File management

  use {
    'ibhagwan/fzf-lua',
    config = function()
      require('config.fzf')
    end,
  }

  use {
    'camspiers/snap',
    cond = function()
      return vim.env.NVIM_FILE_FINDER == 'snap'
    end,
    config = function()
      require('config.snap')
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('config.telescope')
    end,
    requires = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
    },
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = { 'Neotree' },
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('config.tree')
    end,
  }

  -- Lua
  use {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    module = 'persistence',
    config = function()
      require('persistence').setup()
    end,
  }

  use {
    'tamago324/lir.nvim',
    config = function()
      require('config.lir')
    end,
  }

  -- Theme: Colors / Syntax / Icons
  use {
    'rebelot/kanagawa.nvim',
    config = function()
      require('config.theme')
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = function()
      require('config.colorizer')
    end,
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        override = {
          lir_folder_icon = {
            icon = '',
            color = '#7ebae4',
            name = 'lirfoldernode',
          },
        },
      }
    end,
  }

  use { 'SidOfc/mkdx', ft = { 'markdown' } }

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = { 'markdown' },
  }
  use { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } }
  use { 'michaeljsmith/vim-indent-object' }

  -- IDE Stuffs
  use {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    setup = function()
      require('config.blankline')
    end,
    cmd = { 'IndentBlanklineToggle' },
  }

  use { 'liuchengxu/vista.vim', opt = true, cmd = { 'Vista' } }
  use {
    'Darazaki/indent-o-matic',
    config = function()
      require('indent-o-matic').setup {
        filetype_html = {
          standard_widths = { 2 },
        },
        filetype_htmldjango = {
          standard_widths = { 2 },
        },
      }
    end,
  }

  use {
    'rmagatti/goto-preview',
    config = function()
      require('config.preview')
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    opt = true,
    event = 'InsertEnter',
    requires = {
      'hrsh7th/cmp-buffer',
      { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
      'lukas-reineke/cmp-rg',
      'quangnguyen30192/cmp-nvim-tags',
      'octaltree/cmp-look',
      { 'lukas-reineke/cmp-under-comparator', module = 'cmp-under-comparator' },
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'uga-rosa/cmp-dictionary',
      {
        'windwp/nvim-autopairs',
        config = function()
          require('config.autopairs')
        end,
      },
    },
    config = function()
      require('config.cmp')
    end,
  }

  use {
    'mickael-menu/zk-nvim',
    config = function()
      require('zk').setup {
        picker = 'telescope',
      }
    end,
  }

  use { 'onsails/lspkind-nvim' }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('config.snippets')
    end,
    requires = {
      'rafamadriz/friendly-snippets',
    },
  }

  use {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('config.statusline')
    end,
  }

  use {
    {
      'mbbill/undotree',
      config = function()
        require('config.undotree')
      end,
      cmd = { 'UndotreeToggle' },
    },
    {
      'ludovicchabant/vim-gutentags',
      setup = function()
        vim.g.gutentags_project_root = { 'manage.py', 'pyrightconfig.json' }
      end,
      event = 'BufRead',
    },
    {
      'wincent/ferret',
      setup = function()
        vim.g.FerretMap = 0
      end,
      cmd = { 'Ack', 'Lack' },
    },
  }

  use {
    'windwp/nvim-spectre',
    opt = true,
    module = 'spectre',
  }

  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('config.lens')
    end,
  }

  use {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup {
        ignore = { -- do not manage windows matching these file/buftypes
          filetype = { 'help', 'list', 'Trouble' },
          buftype = { 'terminal', 'quickfix', 'loclist', 'nofile' },
        },
      }
    end,
  }

  use {
    'mfussenegger/nvim-dap',
    opt = true,
    module = 'dap',
    requires = {
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    },
  }
  use {
    'numToStr/FTerm.nvim',
    config = function()
      require('config.fterm')
    end,
  }
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
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
      }
    end,
  }

  -- Git stuffs
  use {
    'TimUntersberger/neogit',
    opt = true,
    config = function()
      require('config.neogit')
    end,
    cmd = { 'Neogit' },
    requires = {
      {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
      },
    },
  }
  use {
    'ruifm/gitlinker.nvim',
    config = function()
      require('config.gitlinker')
    end,
    keys = { '<leader>gy' },
  }
  use { 'rhysd/committia.vim', ft = { 'commit', 'gitcommit' } }

  -- Holiness
  use {
    { 'tpope/vim-surround' },
    { 'tpope/vim-markdown', ft = { 'markdown' } },
    { 'tpope/vim-characterize' },
    { 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gwrite' } },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-unimpaired', event = 'BufRead' },
    { 'tpope/vim-apathy', event = 'BufRead' },
    { 'tpope/vim-rsi' },
    { 'tpope/vim-eunuch', opt = true, cmd = { 'Delete', 'Move', 'Rename' } },
    { 'tpope/vim-abolish', cmd = { 'Abolish' } },
    {
      'tpope/vim-scriptease',
      opt = true,
      cmd = { 'Scriptnames', 'Messages', 'Verbose' },
      keys = { 'zS' },
    },
  }

  -- Misc
  use {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('config.keys')
    end,
  }

  use {
    'karb94/neoscroll.nvim',
    cond = false_cb,
    opt = true,
    config = function()
      require('config.scroll')
    end,
  }

  use {
    'wakatime/vim-wakatime',
    event = 'BufReadPre',
  }

  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('config.gitsigns')
    end,
  }

  use {
    'folke/trouble.nvim',
    event = 'BufReadPre',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require('config.trouble')
    end,
  }
  use {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    config = function()
      require('todo-comments').setup {}
    end,
  }
  use {
    'folke/zen-mode.nvim',
    config = function()
      require('config.zen-mode')
    end,
    cmd = { 'ZenMode' },
  }
  use {
    'folke/twilight.nvim',
    config = function()
      require('config.twilight')
    end,
    cmd = { 'Twilight' },
  }
  use {
    'weizheheng/nvim-workbench',
    setup = function()
      vim.g.workbench_border = 'single'
      vim.g.workbench_storage_path = vim.fn.expand('~/Sync/notes/workbench/')
    end,
    module = 'workbench',
  }
  use { 'tversteeg/registers.nvim' }
  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require('rest-nvim').setup()
    end,
    ft = { 'http' },
  }

  use { 'Pocco81/HighStr.nvim' }

  use {
    'simrat39/symbols-outline.nvim',
    setup = function()
      vim.g.symbols_outline = {
        auto_preview = false,
      }
    end,
    cmd = { 'SymbolsOutline' },
  }

  use {
    'RRethy/vim-illuminate',
    event = 'CursorHold',
    module = 'illuminate',
    config = function()
      require('illuminate').configure {
        under_cursor = false,
        delay = 1000,
      }
    end,
  }

  use { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } }
  use { 'simrat39/rust-tools.nvim' }
  use { 'junegunn/vim-easy-align' }
  use { 'stevearc/dressing.nvim' }
  use {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        stages = 'slide',
        timeout = 3000,
      }
    end,
  }
  use {
    'turbio/bracey.vim',
    cmd = 'Bracey',
    run = 'npm install --prefix server',
  }

  use {
    'wincent/command-t',
    -- cond = false_cb,
    opt = true,
    event = 'VimEnter',
    run = 'cd lua/wincent/commandt/lib && make',
    setup = function()
      vim.g.CommandTPreferredImplementation = 'lua'
    end,
    config = function()
      require('wincent.commandt').setup()
    end,
  }
  use { 'andymass/vim-matchup', event = 'BufEnter' }
  use {
    'antoinemadec/FixCursorHold.nvim',
    setup = function()
      vim.g.cursorhold_updatetime = 100
    end,
  }

  use {
    'ray-x/go.nvim',
    requires = {
      'ray-x/guihua.lua',
    },
    ft = { 'go' },
    config = function()
      require('go').setup {
        run_in_floaterm = false,
      }
    end,
  }

  use {
    'declancm/cinnamon.nvim',
    cond = false_cb,
    config = function()
      require('cinnamon').setup {
        extra_keymaps = true,
        scroll_limit = 100,
      }
    end,
  }

  use {
    'ziontee113/syntax-tree-surfer',
    config = function()
      require('config.syntax-tree-surfer')
    end,
  }

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function()
      require('config.ufo')
    end,
  }
  use {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    config = function()
      local saga = require('lspsaga')

      saga.init_lsp_saga {
        -- your configuration
      }
    end,
  }
end

return packer.startup {
  plugins,
  config = {
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}
