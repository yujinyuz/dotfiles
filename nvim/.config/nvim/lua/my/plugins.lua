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
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    config = true,
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  {
    'glepnir/lspsaga.nvim',
    opts = {
      code_action_lightbulb = {
        sign = false,
      },
    },
    branch = 'main',
  },
  { 'folke/neodev.nvim' },
  --- }}}

  -- Ease of editing {{{
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    priority = 100,
    build = function()
      -- require('nvim-treesitter.install').update { with_sync = true }
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'lukas-reineke/cmp-rg',
      'lukas-reineke/cmp-under-comparator',
    },
  },
  {
    'windwp/nvim-autopairs',
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim', 'markdown', 'neo-tree-popup' },
      map_c_w = true,
      check_ts = true,
    },
  },
  { 'windwp/nvim-ts-autotag' },
  { 'numToStr/Comment.nvim', dependencies = 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-rsi' },
  { 'tpope/vim-abolish',     cmd = { 'Abolish' } },
  { 'L3MON4D3/LuaSnip',      dependencies = 'rafamadriz/friendly-snippets' },
  { 'mbbill/undotree',       cmd = { 'UndotreeToggle' } },
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
  { 'yioneko/nvim-yati' }, -- For indentation
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'nvim-treesitter/nvim-treesitter-refactor' },
  { 'p00f/nvim-ts-rainbow' }, -- Colored parens
  --- }}}

  -- File actions and navigations {{{
  { 'ibhagwan/fzf-lua' },
  {
    'tpope/vim-eunuch',
    cmd = { 'Delete', 'Move', 'Rename' },
  },
  {
    'ludovicchabant/vim-gutentags',
    init = function()
      vim.g.gutentags_project_root = { 'manage.py', 'pyrightconfig.json', 'init.lua' }
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = 'MunifTanjim/nui.nvim',
    keys = {
      { '<C-n>', '<Cmd>Neotree toggle<CR>', desc = 'Neotree Toggle' },
    },
  },
  { 'tamago324/lir.nvim' },
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
  {
    'kevinhwang91/nvim-hlslens',
    config = true,
    keys = {
      { 'n',  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { 'N',  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { '*',  [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#',  [[#<Cmd>lua require('hlslens').start()<CR>]] },
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
      { '<leader>gs',  '<Cmd>Git<CR>' },
      { '<leader>gv>', '<Cmd>Gvdiffsplit<CR>' },
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
  },
  { 'lewis6991/gitsigns.nvim' },
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
      vim.cmd([[ colorscheme kanagawa ]])
    end,
  },
  { 'nvim-lualine/lualine.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'onsails/lspkind-nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'j-hui/fidget.nvim',                  opts = { text = { spinner = 'dots_footsteps' } } },
  { 'kevinhwang91/nvim-ufo',              dependencies = 'kevinhwang91/promise-async' },
  --- }}}

  -- General ftplugin {{{
  { 'SidOfc/mkdx',                        ft = 'markdown' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
  { 'Vimjas/vim-python-pep8-indent',   ft = 'python' },
  { 'michaeljsmith/vim-indent-object', ft = 'python' },
  --- }}}

  -- Miscellaneous {{{
  -- { 'lewis6991/impatient.nvim', lazy = false, priority  = 1001 },
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
  { 'akinsho/toggleterm.nvim' },
  { 'weizheheng/nvim-workbench' },
  { 'tversteeg/registers.nvim' },
  { 'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor' },
  --- }}}
}

require('lazy').setup(plugins)

-- vim: foldmethod=marker foldlevel=0
