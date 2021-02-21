" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  ferret = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/ferret"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-gruvbox"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-gruvbox"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  onebuddy = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/onebuddy"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  sgbrowse = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/sgbrowse"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-apathy"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-dyad"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-dyad"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gutentags"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-gutentags"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-scriptease"] = {
    commands = { "Scriptnames", "Messages" },
    keys = { { "", "zS" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-scriptease"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-textobj-indent"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-wakatime"
  }
}


-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Messages lua require("packer.load")({'vim-scriptease'}, { cmd = "Messages", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Scriptnames lua require("packer.load")({'vim-scriptease'}, { cmd = "Scriptnames", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

-- Keymap lazy-loads
vim.cmd [[noremap <silent> zS <cmd>lua require("packer.load")({'vim-scriptease'}, { keys = "zS", prefix = "" }, _G.packer_plugins)<cr>]]

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
