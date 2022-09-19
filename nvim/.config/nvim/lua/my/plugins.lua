local has_packer = pcall(vim.cmd, [[packadd packer.nvim]])

if not has_packer then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  print('Downloading packer.nvim...')
  vim.fn.system(string.format('git clone %s %s --depth 1', 'https://github.com/wbthomason/packer.nvim', install_path))
  vim.cmd([[packadd packer.nvim]])
end

local packer = require('packer')

-- vim.keymap.set('n', '<leader>hpp', '<Cmd>PackerSync<CR>', { desc = 'Packer Sync' })
vim.keymap.set('n', '<leader>hpp', '<Cmd>PackerUpdate --preview<CR>', { desc = 'Packer Sync' })
vim.keymap.set('n', '<leader>hpc', '<Cmd>PackerCompile<CR>', { desc = 'Packer Compile' })

local plugins = function(use)
  -- Prereq packages {{{
  use { 'wbthomason/packer.nvim', opt = true }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  -- }}}

  -- LSP {{{
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim', module = 'null-ls' }
  use { 'glepnir/lspsaga.nvim', branch = 'main' }
  use { 'folke/lua-dev.nvim' }
  --- }}}

  -- Ease of editing {{{
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
  }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'lukas-reineke/cmp-rg' }

  use { 'lukas-reineke/cmp-under-comparator' }
  use { 'windwp/nvim-autopairs' }
  use { 'windwp/nvim-ts-autotag' }
  use { 'numToStr/Comment.nvim', requires = 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-unimpaired' }
  use { 'tpope/vim-rsi' }
  use { 'tpope/vim-abolish', cmd = { 'Abolish' } }
  use { 'L3MON4D3/LuaSnip', requires = 'rafamadriz/friendly-snippets' }
  use { 'mbbill/undotree', cmd = { 'UndotreeToggle' } }
  use { 'nvim-pack/nvim-spectre' }
  use { 'yioneko/nvim-yati', requires = 'nvim-treesitter/nvim-treesitter' } -- For indentation
  use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter' } -- Colored parens
  --- }}}

  -- File actions and navigations {{{
  use { 'ibhagwan/fzf-lua' }
  use { 'tpope/vim-eunuch', opt = true, cmd = { 'Delete', 'Move', 'Rename' } }
  use { 'ludovicchabant/vim-gutentags' }
  use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x', requires = 'MunifTanjim/nui.nvim' }
  use { 'tamago324/lir.nvim' }
  use { 'SmiteshP/nvim-navic' }
  use { 'kevinhwang91/nvim-hlslens' }
  --- }}}

  --- Git {{{
  use { 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gwrite', 'Gvdiffsplit', 'Gdiffsplit' } }
  use { 'TimUntersberger/neogit', cmd = { 'Neogit' }, requires = { 'sindrets/diffview.nvim' } }
  use { 'ruifm/gitlinker.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  --- }}}

  --- Fancy UI {{{
  use { 'nvim-lualine/lualine.nvim' }
  use { 'rebelot/kanagawa.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'onsails/lspkind-nvim' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'j-hui/fidget.nvim' }
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  -- use { 'akinsho/bufferline.nvim', tag = 'v2.*' }
  --- }}}

  -- General ftplugin {{{
  use { 'SidOfc/mkdx', ft = 'markdown' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', ft = 'markdown' }
  use { 'Vimjas/vim-python-pep8-indent', ft = 'python' }
  use { 'michaeljsmith/vim-indent-object', ft = 'python' }
  --- }}}

  -- Miscellaneous {{{
  use { 'lewis6991/impatient.nvim' }
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
  use {
    'tpope/vim-scriptease',
    opt = true,
    cmd = { 'Scriptnames', 'Messages', 'Verbose' },
    keys = { 'zS' },
  }
  use { 'numToStr/FTerm.nvim' }
  use { 'akinsho/toggleterm.nvim' }
  use { 'weizheheng/nvim-workbench', module = 'workbench' }
  use { 'tversteeg/registers.nvim' }
  use { 'nvim-treesitter/playground', cmd = 'TSHighlightCapturesUnderCursor' }
  --- }}}

  if not has_packer then
    packer.sync()
  end
end

local putil = require('packer.util')
local compile_path = putil.join_paths(vim.fn.stdpath('config'), 'plugin', 'generated_packer_compiled.lua')

return packer.startup {
  plugins,
  config = {
    compile_path = compile_path,
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

-- vim: foldmethod=marker foldlevel=0
