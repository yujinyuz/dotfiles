-- Wait for vim.opts to get merged
--  https://github.com/neovim/neovim/pull/13479
local opt = require('modules.lib.nvim_helpers').get_vim_opts()
local data_dir = vim.fn.stdpath('data')

-- Shift 2 spaces when pressing tab
opt.tabstop = 2
-- Shift 2 spaces when pressing < or >
opt.shiftwidth = 2
-- Use spaces instead of tabs
opt.expandtab = true
-- Indents
opt.autoindent = true
opt.cindent = true
-- Make search case insensitive
opt.ignorecase = true
-- .. unless it contains atleast one capital letter
opt.smartcase = true
-- Turn on relative numbers
opt.relativenumber = true
-- .. together with number
opt.number = true
-- Allow vim to set title of the terminal
opt.title = true
-- Change list characters
opt.listchars = [[tab:→ ,trail:·,space:·,eol:↲,nbsp:☠,precedes:«,extends:»,conceal:┊]]
-- Hide buffer when switching to other files
opt.hidden = true
-- Prefer bash for shell-related tasks
opt.shell = '/bin/bash'
-- Disable annoying swapfiles
opt.swapfile = false
-- Use system clipboard
-- go.clipboard = go.clipboard .. "unnamedplus"
opt.clipboard = 'unnamedplus'
-- Search relative to current file and directory
opt.path = '.,**'
-- Split right by default
opt.splitright = true
-- Always show tabs
opt.showtabline = 2
-- Don't wrap words
opt.wrap = false
-- Show highlight when performing substitutions
opt.inccommand = 'split'
-- Enable mouse coz why not?
opt.mouse = 'nicr'
-- Use ripgrep instead of grep
-- opt.grepprg = [[rg --vimgrep --no-heading --smart-case]]

opt.shortmess = opt.shortmess .. 'a'
opt.shortmess = opt.shortmess .. 'I' -- Disable intro message
opt.shortmess = opt.shortmess .. 'c' -- Don't give |ins-completion-menu| messages

-- Formatting
-- vim.cmd [[set formatoptions-=o]] -- O and o, do not continue comments
opt.formatoptions = 'jcrql'

-- opt.completeopt = 'menu,menuone,noselect'
-- opt.completeopt = 'menuone,noselect'
opt.completeopt = 'menuone,noinsert,noselect'
-- Always show sign columns
opt.signcolumn = 'yes'
-- Having longer update time leads to noticeable delays and poor UX
opt.updatetime = 300
-- Start scrolling when we're 8 lines below
opt.scrolloff = 8
-- and 15 lines from the side
opt.sidescrolloff = 15
-- Use a simple statusline
-- opt.statusline = [[[%n] %<%.99f %y%h%w%m%r%=%-14.(%l,%c%V%) %P]]
opt.showmode = false
-- Enable backups
opt.backup = true
-- Ensure filename uniqueness with //
opt.backupdir = data_dir .. '/backup//'
-- Enable persistent undo
opt.undofile = true

opt.wildmenu = true
opt.wildcharm = 26 -- Equivalent of <C-z>

opt.wildmode = 'longest,full'

opt.wildoptions = 'pum'
-- Transparent pums
opt.pumblend = 17

opt.foldlevel = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Enable line wraps. Still testing things out
opt.wrap = true
opt.breakindent = true
-- Make it so long that lines wrap smartly
opt.showbreak = string.rep(' ', 3)
opt.linebreak = true

-- Enable 24-bit RGB color
opt.termguicolors = true
