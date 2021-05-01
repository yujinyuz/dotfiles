local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/opt/packer.nvim'
  print('Downloading packer.nvim...')
  vim.fn.system(
    string.format(
      'git clone %s %s', 'https://github.com/wbthomason/packer.nvim',
      install_path
    )
  )
end

local packer = require('packer')
local disable = function() return false end
local plugins = function(use)
  use {'wbthomason/packer.nvim', opt = true}
  use {'tjdevries/astronauta.nvim'}

  -- File management
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-fzf-writer.nvim',
    },
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }
  use {'justinmk/vim-dirvish', cond = disable}
  use {'tamago324/lir.nvim'}

  -- Colors / Syntax
  use {'SidOfc/mkdx'}
  use {'gruvbox-community/gruvbox'}
  use {'sainnhe/gruvbox-material'}
  use {'tjdevries/gruvbuddy.nvim'}
  use {'Th3Whit3Wolf/onebuddy'}
  use {'tjdevries/colorbuddy.vim'}
  use {'RishabhRD/nvim-gruvbox'}
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup {} end,
  } -- colorize hex/rgb/hsl value
  use {
    'nvim-treesitter/nvim-treesitter',
    -- run = ':TSUpdate',
    requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects'},
      {'nvim-treesitter/nvim-treesitter-refactor'},
      {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end,
      },
      {'JoosepAlviste/nvim-ts-context-commentstring'},
    },
  }

  use {
    'code-biscuits/nvim-biscuits',
    -- config = function() require('nvim-biscuits').setup({}) end,
    opt = true,
    cond = disable,
  }
  use {'romgrk/nvim-treesitter-context', cond = disable, opt = true}

  -- IDE Stuffs
  use {'neovim/nvim-lspconfig'}
  use {'glepnir/lspsaga.nvim'}
  use {'Vimjas/vim-python-pep8-indent'}
  use {'mbbill/undotree', opt = true, cmd = {'UndotreeToggle'}}
  use {'hrsh7th/nvim-compe'}

  use {'SirVer/ultisnips', requires = {{'honza/vim-snippets'}}}

  use {'ludovicchabant/vim-gutentags'}
  use {'wincent/ferret'}
  use {'wincent/loupe'}
  use {
    'mfussenegger/nvim-dap',
    requires = {
      {'mfussenegger/nvim-dap-python'},
      {'theHamsta/nvim-dap-virtual-text'},
    },
  }

  use {'hoob3rt/lualine.nvim'}

  -- Holiness
  use {'tpope/vim-surround'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-fugitive'}
  use {'camdencheek/sgbrowse'}
  -- use {'tpope/vim-endwise'}
  use {'tpope/vim-repeat'}
  -- use {'tpope/vim-obsession'}
  use {'tpope/vim-unimpaired'}
  use {'tpope/vim-eunuch'}
  use {
    'tpope/vim-scriptease',
    opt = true,
    cmd = {'Scriptnames', 'Messages'},
    keys = {'zS'},
  }
  use {'tpope/vim-rhubarb'}
  use {'tpope/vim-apathy'}
  use {'tpope/vim-rsi'}
  use {'windwp/nvim-autopairs'}
  use {'tpope/vim-dispatch'}
  use {'tpope/vim-projectionist'}

  -- Misc
  -- use {'honza/vim-snippets'}
  use {'junegunn/vim-easy-align'}
  use {'kana/vim-textobj-user'}
  use {'kana/vim-textobj-entire'} -- [ae]
  use {'kana/vim-textobj-indent'} -- [ai]/[ii]
  use {'wakatime/vim-wakatime'} -- track usage time using wakatime
  use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
  use {'f-person/git-blame.nvim'}
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup {signcolumn = false} end,
  }
  use {'TimUntersberger/neogit'}
  use {
    'ruifm/gitlinker.nvim',
    config = function() require('gitlinker').setup {} end,
  }
  use {
    'folke/lsp-trouble.nvim',
    config = function() require('trouble').setup {} end,
  }
  use {'marcushwz/nvim-workbench'}
  use {'nvim-treesitter/playground'}
end

return packer.startup(plugins)
