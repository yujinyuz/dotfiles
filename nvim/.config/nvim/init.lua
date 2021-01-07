local go = vim.o
local bo = vim.bo
local wo = vim.wo
local data_dir = vim.fn.stdpath('data')


-- There isn't an alternative to `set <option>` in Lua as of writing this
-- so some options need to be defined twice.
-- Shift 2 spaces when pressing tab
go.tabstop = 2
bo.tabstop = 2
-- Shift 2 spaces when pressing < or >
go.shiftwidth = 2
bo.shiftwidth = 2
-- Use spaces instead of tabs
go.expandtab = true
bo.expandtab = true
-- Make search case insensitive
go.ignorecase = true
-- .. unless it contains atleast one capital letter
go.smartcase = true
-- Turn on relative numbers
wo.relativenumber = true
-- .. together with number
wo.number = true
-- Allow vim to set title of the terminal
go.title = true
-- Hide buffer when switching to other files
go.hidden = true
-- Prefer bash for shell-related tasks
go.shell = "/bin/bash"
-- Disable annoying swapfiles
go.swapfile = false
bo.swapfile = false
-- Use system clipboard
go.clipboard = go.clipboard .. "unnamedplus"
-- Search relative to current file and directory
go.path = ".,**"
-- Split right by default
go.splitright = true
-- Always show tabs
go.showtabline = 2
-- Don't wrap words
wo.wrap = false
-- Show highlight when performing substitutions
go.inccommand = "split"
-- Enable mouse coz why not?
go.mouse = "nicr"
-- Use ripgrep instead of grep
go.grepprg = [[rg --vimgrep --no-heading --smart-case]]
-- Disable intro message
go.shortmess = go.shortmess .. "I"
-- Don't give |ins-completion-menu| messages
go.shortmess = go.shortmess .. "c"
go.completeopt = "menuone,noinsert,noselect"
-- Always show sign columns
wo.signcolumn = "yes"
-- Having longer update time leads to noticeable delays and poor UX
go.updatetime = 300
-- Start scrolling when we're 8 lines below
go.scrolloff = 8
-- and 15 lines from the side
go.sidescrolloff = 15
-- Use a simple statusline
go.statusline = [[[%n] %<%.99f %y%h%w%m%r%=%-14.(%l,%c%V%) %P]]
-- Enable backups
go.backup = true
-- Ensure filename uniqueness with //
go.backupdir = data_dir .. '/backup//'
-- Enable persistent undo
go.undofile = true
bo.undofile = true

-- Use Space as the leader key
vim.g.mapleader = ' '
vim.g.python3_host_prog = os.getenv('PYTHON_3_HOST_PROG')

require("jyz.plugins")
require("jyz.plugins_config")
require("jyz.native_keymaps")
