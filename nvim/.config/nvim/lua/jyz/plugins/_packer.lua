local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
	print('Downloading packer.nvim...')
	vim.fn.system(string.format(
			'git clone %s %s',
			'https://github.com/wbthomason/packer.nvim',
			install_path
		)
	)
end

local packer = require('packer')
local plugins = function()
	use {'wbthomason/packer.nvim', opt = true}

  -- File management
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
		},
	}
	use {
		'nvim-telescope/telescope-fzy-native.nvim',
		requires = {
			'nvim-telescope/telescope.nvim'
		}
	}
	use {'kyazdani42/nvim-tree.lua'}
  use {'justinmk/vim-dirvish'}


  -- Colors / Syntax
	use {'gruvbox-community/gruvbox'}
	use {'norcalli/nvim-colorizer.lua'} -- colorize hex/rgb/hsl value
	use {'sheerun/vim-polyglot'}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
      vim.cmd [[TSUdpate]]
    end
	}

  -- IDE Stuffs
  use {'neovim/nvim-lspconfig'}
  use {'yujinyuz/vim-dyad'}
  use {'dense-analysis/ale'}
  use {
    'nvim-lua/completion-nvim',
    requires = {
      'neovim/nvim-lspconfig'
    }
  }
  use {
    'steelsojka/completion-buffers',
    requires = {
      'nvim-lua/completion-nvim',
    }
  }
  use {
    'kristijanhusak/completion-tags',
    requires = {
      'nvim-lua/completion-nvim'
    }
  }
  use {'ludovicchabant/vim-gutentags'}
  use {'wincent/ferret'}

  -- Holiness
  use {'tpope/vim-surround'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-fugitive'}
  -- use {'tpope/vim-endwise'}
  use {'tpope/vim-repeat'}
  -- use {'tpope/vim-obsession'}
  use {'tpope/vim-unimpaired'}
  -- use {'tpope/vim-dispatch'}
  use {'tpope/vim-eunuch'}
  use {'tpope/vim-scriptease'}
  use {'tpope/vim-rhubarb'}
  use {'tpope/vim-apathy'}
  use {'tpope/vim-projectionist'}

  -- Misc
  -- use {'junegunn/vim-slash'} -- Enhances buffer search
  -- use {'honza/vim-snippets'}
  use {'kana/vim-textobj-user'}
  use {'kana/vim-textobj-entire'} -- [ae]
  use {'kana/vim-textobj-indent'} -- [ai]/[ii]
	use {'wakatime/vim-wakatime'} -- track usage time using wakatime
  use {'tmux-plugins/vim-tmux-focus-events'} -- Useful when `autoread` is enabled
end

vim.g.polyglot_disabled = {
  'markdown',
  'python.plugin',
  'html.plugin',
  'javascript.plugin',
}
vim.g.ale_linters_explicit = 1
vim.g.ale_fixers = {
  python = {'autopep8', 'isort'}
}
vim.g.ale_sign_error = '✘'
vim.g.ale_sign_warning = '⚠'

return packer.startup(plugins)
