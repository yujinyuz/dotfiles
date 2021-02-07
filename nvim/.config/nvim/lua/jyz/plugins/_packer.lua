local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  print('Downloading packer.nvim...')
  vim.fn.system(string.format(
      'git clone %s %s',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    )
  )
end

local packer = require('packer')
local plugins = function(use)
  use {'wbthomason/packer.nvim', opt = true}

  -- File management
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-fzf-writer.nvim'
    },
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'justinmk/vim-dirvish',
  }

  -- Colors / Syntax
  use {'gruvbox-community/gruvbox'}
  use {'sainnhe/gruvbox-material'}
  use {'tjdevries/gruvbuddy.nvim'}
  use {'Th3Whit3Wolf/onebuddy'}
  use {'tjdevries/colorbuddy.vim'}
  use {'RishabhRD/nvim-gruvbox'}
  use {'norcalli/nvim-colorizer.lua'} -- colorize hex/rgb/hsl value
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects'},
      {'nvim-treesitter/nvim-treesitter-refactor'},
      -- {'romgrk/nvim-treesitter-context'},
    }
  }

  -- IDE Stuffs
  use {'neovim/nvim-lspconfig'}
  use {'yujinyuz/vim-dyad'}
  use {'Vimjas/vim-python-pep8-indent'}
  use {'alvan/vim-closetag'}
  use {
    'mbbill/undotree',
    opt = true,
    cmd = {'UndotreeToggle'}
  }
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        allow_prefix_unmatch = false,

        -- priority: Higher means top of the list
        source = {
          nvim_lsp = {
            priority = 100,
          },
          nvim_lua = {
            priority = 100,
          },
          treesitter = {
            priority = 90,
            dup = false,
          },
          tags = {
            priority = 50,
            dup = false,
          },
          buffer = {
            priority = 40,
            dup = false,
          },
          path = true,
        }
      }
    end
  }

  use {
    'SirVer/ultisnips',
    requires = {
      {'honza/vim-snippets'},
    },
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<C-l>'
    end
  }

  use {'ludovicchabant/vim-gutentags'}
  use {'wincent/ferret'}
  use {
    'mfussenegger/nvim-dap',
    requires = {
      {'mfussenegger/nvim-dap-python'},
      {'theHamsta/nvim-dap-virtual-text'},
    }
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      local lualine = require('lualine')
      local function filename()
        return [[%<%.15f %m]]
      end
      vim.o.showmode = false

      lualine.theme = 'gruvbox_material'
      -- lualine.theme = 'gruvbox'
      lualine.separator = '|'
      lualine.sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location'  },
      }
      lualine.inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { filename },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {   }
      }
      -- lualine.extensions = { 'fzf' }
      lualine.status()
    end
  }

  -- Holiness
  use {'tpope/vim-surround'}
  use {'tpope/vim-commentary'}
  use {
    'tpope/vim-fugitive',
    opt = true,
    cmd = {'G', 'Git', 'Glog', 'Gbrowse', 'Gblame', 'Gcommit', 'Gcd', 'Gvdiffsplit', 'Gwrite'}
  }
  -- use {'tpope/vim-endwise'}
  use {'tpope/vim-repeat'}
  -- use {'tpope/vim-obsession'}
  use {'tpope/vim-unimpaired'}
  use {'tpope/vim-eunuch'}
  use {
    'tpope/vim-scriptease',
    opt = true,
    cmd = {'Scriptnames', 'Messages'},
    keys = {'zS'}
  }
  use {'tpope/vim-rhubarb'}
  use {'tpope/vim-apathy'}
  use {'tpope/vim-rsi'}
  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }
  use {'tpope/vim-projectionist'}

  -- Misc
  -- use {'junegunn/vim-slash'} -- Enhances buffer search
  -- use {'honza/vim-snippets'}
  use {'kana/vim-textobj-user'}
  use {'kana/vim-textobj-entire'} -- [ae]
  use {'kana/vim-textobj-indent'} -- [ai]/[ii]
  use {'wakatime/vim-wakatime'} -- track usage time using wakatime
end

return packer.startup(plugins)
