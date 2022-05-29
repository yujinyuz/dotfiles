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
  use { 'williamboman/nvim-lsp-installer' }

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
      { 'eddiebergman/nvim-treesitter-pyfold' },
      {
        'windwp/nvim-ts-autotag',
      },
    },
  }
  use { 'ThePrimeagen/refactoring.nvim' }
  use {
    'SmiteshP/nvim-gps',
    config = function()
      require('nvim-gps').setup()
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
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
    opt = true,
    event = 'VimEnter',
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
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
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

  use { 'liuchengxu/vista.vim' }
  use { 'Darazaki/indent-o-matic' }

  use {
    'rmagatti/goto-preview',
    config = function()
      require('config.preview')
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
      'lukas-reineke/cmp-rg',
      'quangnguyen30192/cmp-nvim-tags',
      'octaltree/cmp-look',
      'lukas-reineke/cmp-under-comparator',
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
        vim.g.gutentags_project_root = { 'manage.py' }
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
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-unimpaired', event = 'BufRead' },
    { 'tpope/vim-apathy', event = 'BufRead' },
    { 'tpope/vim-rsi' },
    { 'tpope/vim-eunuch', opt = true, cmd = { 'Delete', 'Move', 'Rename' } },
    { 'tpope/vim-abolish' },
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
    'nathom/filetype.nvim',
    config = function()
      require('filetype').setup {}
    end,
  }

  use {
    'wakatime/vim-wakatime',
    event = 'BufReadPre',
  }

  use {
    'lewis6991/gitsigns.nvim',
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
    'marcushwz/nvim-workbench',
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
  use {
    '~/Sources/tablea.nvim',
    config = function()
      require('tablea').setup { show_index = false, show_modify = true }
    end,
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
      vim.g.Illuminate_delay = 1000
    end,
  }

  use { 'kazhala/close-buffers.nvim', cmd = 'BDelete' }
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
    'hoschi/yode-nvim',
    config = function()
      require('yode-nvim').setup {}
    end,
  }

  use {
    'turbio/bracey.vim',
    cmd = 'Bracey',
    run = 'npm install --prefix server',
  }

  use {
    'wincent/command-t',
    cond = false_cb,
    event = 'VimEnter',
    setup = function()
      vim.g.CommandTEncoding = 'UTF-8'
      vim.g.CommandTFileScanner = 'watchman'
      -- vim.g.CommandTInputDebounce = 50
      vim.g.CommandTMaxCachedDirectories = 10
      vim.g.CommandTMaxFiles = 3000000
      vim.g.CommandTScanDotDirectories = 1
      vim.g.CommandTTraverseSCM = 'pwd'
      vim.g.CommandTWildIgnore = vim.o.wildignore
        .. ',*/.git/*'
        .. ',*/.hg/*'
        .. ',*/bower_components/*'
        .. ',*/tmp/*'
        .. ',*.class'
        .. ',*/classes/*'
        .. ',*/build/*'
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
end

return packer.startup {
  plugins,
  config = {
    max_jobs = 32, -- Prevents from hanging, though higher == faster
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}
