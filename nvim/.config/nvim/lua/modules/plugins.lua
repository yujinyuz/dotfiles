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
  use {'lambdalisue/suda.vim', cond = disable}
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
  use {'tamago324/lir.nvim'}

  -- Colors / Syntax
  use {'SidOfc/mkdx'}
  use {'gruvbox-community/gruvbox'}
  use {'sainnhe/gruvbox-material'}
  use {'tjdevries/gruvbuddy.nvim'}
  use {'Th3Whit3Wolf/onebuddy'}
  use {'tjdevries/colorbuddy.vim'}
  use {'RishabhRD/nvim-gruvbox'}
  use {'folke/tokyonight.nvim'}
  use {'eddyekofo94/gruvbox-flat.nvim'}
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
  use {'kabouzeid/nvim-lspinstall'}
  use {'glepnir/lspsaga.nvim'}
  use {'Vimjas/vim-python-pep8-indent'}
  use {'mbbill/undotree', opt = true, cmd = {'UndotreeToggle'}}
  use {'windwp/nvim-autopairs'}
  use {'hrsh7th/nvim-compe'}
  use {'ludovicchabant/vim-gutentags'}
  use {'wincent/ferret'}
  use {'kevinhwang91/nvim-hlslens'}
  use {'mfussenegger/nvim-dap'}
  use {'mfussenegger/nvim-dap-python'}
  use {'theHamsta/nvim-dap-virtual-text'}
  use {'hoob3rt/lualine.nvim'}
  use {'SirVer/ultisnips'}
  use {'honza/vim-snippets'}
  use {'windwp/nvim-spectre'}
  use {
    "numtostr/FTerm.nvim",
    config = function()
      require("FTerm").setup()
    end
  }
  use {
    'folke/lua-dev.nvim'
  }

  -- Git stuffs
  use {'sindrets/diffview.nvim'}
  use {
    'ruifm/gitlinker.nvim',
    config = function() require('gitlinker').setup {} end,
  }
  use {'f-person/git-blame.nvim'}
  use {
    'TimUntersberger/neogit',
    config = function()
      require('neogit').setup {integrations = {diffview = true}, disable_commit_confirmation = true}
    end,
  }

  -- Holiness
  use {'tpope/vim-surround'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-unimpaired'}
  use {
    'tpope/vim-scriptease',
    opt = true,
    cmd = {'Scriptnames', 'Messages'},
    keys = {'zS'},
  }
  use {'tpope/vim-apathy'}
  use {'tpope/vim-rsi'}
  use {'tpope/vim-projectionist'}

  -- Misc
  use {'junegunn/vim-easy-align'}
  use {'kana/vim-textobj-user'}
  use {'kana/vim-textobj-entire'} -- [ae]
  use {'kana/vim-textobj-indent'} -- [ai]/[ii]
  use {'wakatime/vim-wakatime'} -- track usage time using wakatime
  use {'lukas-reineke/indent-blankline.nvim'}
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup {signcolumn = false} end,
  }
  use {
    'folke/trouble.nvim',
    config = function() require('trouble').setup {} end,
  }
  use {
    'folke/todo-comments.nvim',
    config = function() require('todo-comments').setup {} end,
  }
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
      }
    end
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = {
          twilight = { enabled = false }
        }
      }
    end
  }
  use {'marcushwz/nvim-workbench'}
  use {'nvim-treesitter/playground'}
  use {'tversteeg/registers.nvim'}
  use {'NTBBloodbath/rest.nvim'}
  use {
    '~/Sources/tablea.nvim',
    config = function()
      require('tablea').setup {show_index = false, show_modify = true}
    end,
  }
  use {
    'camspiers/snap',
    config = function()

      local snap = require('snap')
      local file = snap.config.file:with{reverse = false, consumer = 'fzf'}
      local vimgrep = snap.config.vimgrep:with{
        reverse = false,
        consumer = 'fzf',
        limit = 50000,
      }

      snap.maps {
        {
          '<leader><leader>', file {
            try = {
              snap.get('producer.git.file').args({'--cached', '--others', '--exclude-standard'}),
              'ripgrep.file',
            },
            prompt = 'Files',
          },
        },
        {'<leader>F', vimgrep {
          -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
          producer = snap.get('producer.ripgrep.vimgrep').line {'--hidden'},
          prompt = 'Live Grep'
        }},
      }
    end,
  }
end

return packer.startup(plugins)
