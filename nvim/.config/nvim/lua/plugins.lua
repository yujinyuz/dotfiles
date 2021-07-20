local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  print('Downloading packer.nvim...')
  vim.fn.system(string.format('git clone %s %s', 'https://github.com/wbthomason/packer.nvim', install_path))
end

local packer = require('packer')

local plugins = function(use)
  local function disable()
    return true
  end

  use({ 'wbthomason/packer.nvim', opt = true })

  use({
    { 'nvim-lua/popup.nvim', module = 'popup' },
    { 'nvim-lua/plenary.nvim', module = 'plenary' },
  })

  -- LSP Stuffs
  use({
    'neovim/nvim-lspconfig',
    opt = true,
    event = 'BufReadPre',
    wants = { 'nvim-lsp-ts-utils', 'null-ls.nvim', 'lua-dev.nvim' },
    config = function()
      require('config.lsp')
    end,
    requires = {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
      'folke/lua-dev.nvim',
    },
  })

  -- Comments
  use({
    'b3nj5m1n/kommentary',
    opt = true,
    wants = 'nvim-ts-context-commentstring',
    keys = { 'gc', 'gcc' },
    config = function()
      require('config.kommentary')
    end,
    requires = 'JoosepAlviste/nvim-ts-context-commentstring',
  })

  -- AST Syntax Highlighting
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    opt = true,
    event = 'BufRead',
    config = function()
      -- @note: For some reason, nvim-treesitter-textobjects.select doesn't work if I don't defer its loading.
      -- e.g. `yac`, `yif` won't work. Though incremental_selection and `nvim-treesitter-text-objects.move` does.
      vim.defer_fn(function()
        require('config.treesitter')
      end, 0)
    end,
    requires = {
      { 'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor' },
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
      {
        'windwp/nvim-ts-autotag',
        config = function()
          require('nvim-ts-autotag').setup()
        end,
      },
    },
  })

  -- File management
  use({
    'camspiers/snap',
    event = 'VimEnter',
    config = function()
      require('config.snap')
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    config = function()
      require('config.telescope')
    end,
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    cmd = { 'Telescope' },
    module = 'telescope',
  })

  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('config.tree')
    end,
    cmd = { 'NvimTreeToggle' },
  })

  use({
    'tamago324/lir.nvim',
    module = 'lir',
    setup = function()
      require('config.lir')
    end,
  })

  -- Theme: Colors / Syntax / Icons
  use({
    'folke/tokyonight.nvim',
    config = function()
      require('config.theme')
    end,
  })
  use({ 'eddyekofo94/gruvbox-flat.nvim', opt = true })
  use({
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = function()
      require('config.colorizer')
    end,
  })
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        override = {
          lir_folder_icon = {
            icon = '',
            color = '#7ebae4',
            name = 'lirfoldernode',
          },
        },
      })
    end,
  })
  use({ 'SidOfc/mkdx', ft = { 'markdown' } })
  use({ 'Vimjas/vim-python-pep8-indent', ft = { 'python' } })

  -- IDE Stuffs
  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    setup = function()
      require('config.blankline')
    end,
    cmd = { 'IndentBlanklineToggle' },
  })
  use({
    'hrsh7th/nvim-compe',
    event = 'InsertEnter',
    opt = true,
    config = function()
      require('config.compe')
    end,
    requires = {
      {
        'windwp/nvim-autopairs',
        config = function()
          require('config.autopairs')
        end,
      },
    },
  })

  use({
    'hoob3rt/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('config.lualine')
    end,
  })

  use({
    {
      'mbbill/undotree',
      config = function()
        require('config.undotree')
      end,
      cmd = { 'UndotreeToggle' },
    },
    'ludovicchabant/vim-gutentags',
    {
      'wincent/ferret',
      setup = function()
        vim.g.FerretMap = 0
      end,
      cmd = { 'Ack', 'Lack' },
    },
    'SirVer/ultisnips',
    'honza/vim-snippets',
  })

  use({
    'windwp/nvim-spectre',
    opt = true,
    module = 'spectre',
  })

  use({ 'kabouzeid/nvim-lspinstall' })
  use({ 'glepnir/lspsaga.nvim', cond = disable })
  use({ 'kevinhwang91/nvim-hlslens' })
  use({
    'mfussenegger/nvim-dap',
    opt = true,
    module = 'dap',
    requires = {
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    },
  })
  use({
    'numtostr/FTerm.nvim',
    config = function()
      require('config.fterm')
    end,
    module = 'FTerm',
  })

  -- Git stuffs
  use({
    'TimUntersberger/neogit',
    config = function()
      require('config.neogit')
    end,
    cmd = { 'Neogit' },
    requires = {
      {
        'sindrets/diffview.nvim',
        opt = true,
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
      },
    },
  })
  use({
    'ruifm/gitlinker.nvim',
    config = function()
      require('config.gitlinker')
    end,
    keys = { '<leader>gy' },
  })
  use({ 'f-person/git-blame.nvim', cmd = { 'GitBlameToggle' } })

  -- Holiness
  use({
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-apathy',
    'tpope/vim-rsi',
    {
      'tpope/vim-scriptease',
      opt = true,
      cmd = { 'Scriptnames', 'Messages', 'Verbose' },
      keys = { 'zS' },
    },
  })

  -- Misc
  use({
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('config.keys')
    end,
  })

  use({
    'karb94/neoscroll.nvim',
    keys = { '<C-u>', '<C-d>', 'gg', 'G' },
    config = function()
      require('config.scroll')
    end,
    cond = disable,
  })

  use({
    'kana/vim-textobj-user',
    'kana/vim-textobj-entire', -- [ae]
    'kana/vim-textobj-indent', -- [ai]/[ii]
    'wakatime/vim-wakatime', -- track usage time using wakatime
  })
  use({
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require('config.gitsigns')
    end,
  })
  use({
    'folke/trouble.nvim',
    event = 'BufReadPre',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require('config.trouble')
    end,
  })
  use({
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    config = function()
      require('todo-comments').setup({})
    end,
  })
  use({
    'folke/zen-mode.nvim',
    config = function()
      require('config.zen-mode')
    end,
    cmd = { 'ZenMode' },
  })
  use({
    'folke/twilight.nvim',
    config = function()
      require('config.twilight')
    end,
    cmd = { 'Twilight' },
  })
  use({
    'marcushwz/nvim-workbench',
    config = function()
      require('config.workbench')
    end,
    module = 'workbench',
  })
  use({ 'tversteeg/registers.nvim' })
  use({
    'NTBBloodbath/rest.nvim',
    config = function()
      require('rest-nvim').setup()
    end,
    ft = 'http',
  })
  use({
    '~/Sources/tablea.nvim',
    config = function()
      require('tablea').setup({ show_index = false, show_modify = true })
    end,
  })
end

return packer.startup({
  plugins,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
})
