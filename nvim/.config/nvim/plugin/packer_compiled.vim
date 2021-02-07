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
  local success, err = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(err)
  end
end

_G.packer_plugins = {
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
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\26\0\0\1\0\1\0\2'\0\0\0L\0\2\0\15%<%.15f %mæ\3\1\0\4\0\27\0-6\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2+\3\1\0=\3\5\2'\2\a\0=\2\6\0'\2\t\0=\2\b\0005\2\f\0005\3\v\0=\3\r\0025\3\14\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\17\0=\3\18\0025\3\19\0=\3\20\0025\3\21\0=\3\22\2=\2\n\0005\2\24\0004\3\0\0=\3\r\0024\3\0\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\25\0=\3\18\0024\3\0\0=\3\20\0024\3\0\0=\3\22\2=\2\23\0009\2\26\0B\2\1\1K\0\1\0\vstatus\1\2\0\0\rlocation\1\0\0\22inactive_sections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\rsections\6|\14separator\21gruvbox_material\ntheme\rshowmode\6o\bvim\0\flualine\frequire\0" },
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\n \2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\vsource\vbuffer\1\0\2\bdup\1\rpriority\3(\ttags\1\0\2\bdup\1\rpriority\0032\15treesitter\1\0\2\bdup\1\rpriority\3Z\rnvim_lua\1\0\1\rpriority\3d\rnvim_lsp\1\0\1\tpath\2\1\0\1\rpriority\3d\1\0\6\ndebug\1\25allow_prefix_unmatch\1\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\nsetup\ncompe\frequire\0" },
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
    config = { "\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-l>\27UltiSnipsExpandTrigger\6g\bvim\0" },
    loaded = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
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
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
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
    commands = { "G", "Git", "Glog", "Gbrowse", "Gblame", "Gcommit", "Gcd", "Gvdiffsplit", "Gwrite" },
    loaded = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
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

-- Config for: ultisnips
try_loadstring("\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-l>\27UltiSnipsExpandTrigger\6g\bvim\0", "config", "ultisnips")
-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n\26\0\0\1\0\1\0\2'\0\0\0L\0\2\0\15%<%.15f %mæ\3\1\0\4\0\27\0-6\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2+\3\1\0=\3\5\2'\2\a\0=\2\6\0'\2\t\0=\2\b\0005\2\f\0005\3\v\0=\3\r\0025\3\14\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\17\0=\3\18\0025\3\19\0=\3\20\0025\3\21\0=\3\22\2=\2\n\0005\2\24\0004\3\0\0=\3\r\0024\3\0\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\25\0=\3\18\0024\3\0\0=\3\20\0024\3\0\0=\3\22\2=\2\23\0009\2\26\0B\2\1\1K\0\1\0\vstatus\1\2\0\0\rlocation\1\0\0\22inactive_sections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\rsections\6|\14separator\21gruvbox_material\ntheme\rshowmode\6o\bvim\0\flualine\frequire\0", "config", "lualine.nvim")
-- Config for: nvim-compe
try_loadstring("\27LJ\2\n \2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\vsource\vbuffer\1\0\2\bdup\1\rpriority\3(\ttags\1\0\2\bdup\1\rpriority\0032\15treesitter\1\0\2\bdup\1\rpriority\3Z\rnvim_lua\1\0\1\rpriority\3d\rnvim_lsp\1\0\1\tpath\2\1\0\1\rpriority\3d\1\0\6\ndebug\1\25allow_prefix_unmatch\1\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\nsetup\ncompe\frequire\0", "config", "nvim-compe")

-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file Gcommit lua require("packer.load")({'vim-fugitive'}, { cmd = "Gcommit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gcd lua require("packer.load")({'vim-fugitive'}, { cmd = "Gcd", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gwrite lua require("packer.load")({'vim-fugitive'}, { cmd = "Gwrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gvdiffsplit lua require("packer.load")({'vim-fugitive'}, { cmd = "Gvdiffsplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Scriptnames lua require("packer.load")({'vim-scriptease'}, { cmd = "Scriptnames", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Messages lua require("packer.load")({'vim-scriptease'}, { cmd = "Messages", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Glog lua require("packer.load")({'vim-fugitive'}, { cmd = "Glog", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gbrowse lua require("packer.load")({'vim-fugitive'}, { cmd = "Gbrowse", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gblame lua require("packer.load")({'vim-fugitive'}, { cmd = "Gblame", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

-- Keymap lazy-loads
vim.cmd [[noremap <silent> zS <cmd>lua require("packer.load")({'vim-scriptease'}, { keys = "zS", prefix = "" }, _G.packer_plugins)<cr>]]

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
