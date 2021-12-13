-- https://github.com/wbthomason/packer.nvim/issues/180#issuecomment-871634199
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  print('Downloading packer.nvim...')
  vim.fn.system(string.format('git clone %s %s --depth 1', 'https://github.com/wbthomason/packer.nvim', install_path))
  vim.cmd([[packadd packer.nvim]])
end

local packer = require('packer')

local plugins = function(use)
  local function disable()
    return true
  end

  use({ 'wbthomason/packer.nvim', opt = true })
  use({ 'lewis6991/impatient.nvim' })

  use({
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
  })

  -- LSP Stuffs
  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
    requires = {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
      'folke/lua-dev.nvim',
    },
  })
  use({ 'williamboman/nvim-lsp-installer' })

  -- Comments
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('config.comments')
    end,
    requires = 'JoosepAlviste/nvim-ts-context-commentstring',
  })

  -- AST Syntax Highlighting
  use({
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
    'ibhagwan/fzf-lua',
    config = function()
      require('config.fzf')
    end,
  })

  use({
    'camspiers/snap',
    opt = true,
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
  })

  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('config.tree')
    end,
  })

  use({
    'tamago324/lir.nvim',
    config = function()
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
  use({ 'rwxrob/vim-pandoc-syntax-simple', ft = { 'markdown' } })
  use({ 'Vimjas/vim-python-pep8-indent', ft = { 'python' } })
  use({ 'michaeljsmith/vim-indent-object' })

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
    'code-biscuits/nvim-biscuits',
    config = function()
      require('nvim-biscuits').setup({})
    end,
  })

  use({
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup()
    end,
  })

  use({ 'liuchengxu/vista.vim' })

  use({
    'rmagatti/goto-preview',
    config = function()
      require('config.preview')
    end,
  })

  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'lukas-reineke/cmp-rg',
      'quangnguyen30192/cmp-nvim-tags',
      'octaltree/cmp-look',
      'lukas-reineke/cmp-under-comparator',
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
  })

  use({ 'onsails/lspkind-nvim' })

  use({
    'L3MON4D3/LuaSnip',
    -- event = 'InsertEnter',
    config = function()
      require('config.snippets')
    end,
    requires = {
      'rafamadriz/friendly-snippets',
    },
  })

  use({
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('config.statusline')
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
    { 'ludovicchabant/vim-gutentags', event = 'BufRead' },
    {
      'wincent/ferret',
      setup = function()
        vim.g.FerretMap = 0
      end,
      cmd = { 'Ack', 'Lack' },
    },
  })

  use({
    'windwp/nvim-spectre',
    opt = true,
    module = 'spectre',
  })

  use({
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('config.lens')
    end,
  })

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
  })
  use({
    'ruifm/gitlinker.nvim',
    config = function()
      require('config.gitlinker')
    end,
    keys = { '<leader>gy' },
  })
  use({ 'rhysd/committia.vim', ft = { 'commit', 'gitcommit' } })

  -- Holiness
  use({
    { 'tpope/vim-sleuth' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-markdown', ft = { 'markdown' } },
    { 'tpope/vim-characterize' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-unimpaired', event = 'BufRead' },
    { 'tpope/vim-apathy', event = 'BufRead' },
    { 'tpope/vim-rsi' },
    { 'tpope/vim-eunuch', opt = true, cmd = { 'Delete', 'Move', 'Rename' } },
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
    -- event = 'VimEnter',
    config = function()
      require('config.keys')
    end,
  })

  use({
    'karb94/neoscroll.nvim',
    -- keys = { '<C-u>', '<C-d>', 'gg', 'G' },
    opt = true,
    config = function()
      require('config.scroll')
    end,
  })

  use({
    'nathom/filetype.nvim',
  })

  use({
    'wakatime/vim-wakatime',
    event = 'BufReadPre',
  })

  use({
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
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
    ft = { 'http' },
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
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
    display = {
      -- open_fn = function()
      --   return require('packer.util').float({ border = 'single' })
      -- end,
    },
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
})
