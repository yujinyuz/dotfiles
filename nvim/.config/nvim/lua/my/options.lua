-- Shift 2 spaces when pressing tab
vim.opt.tabstop = 2
-- Shift 2 spaces when pressing < or >
vim.opt.shiftwidth = 2
-- Round indent spacing with the multiples of shiftwidth
vim.opt.shiftround = true
-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Indents
vim.opt.autoindent = true
-- Make search case insensitive
vim.opt.ignorecase = true
-- .. unless it contains atleast one capital letter
vim.opt.smartcase = true
-- Turn on relative numbers
vim.opt.relativenumber = true
-- .. together with number
vim.opt.number = true
-- Allow vim to set title of the terminal
vim.opt.title = true
-- Change list characters
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  space = '·',
  -- eol = '↲',
  eol = '↴',
  nbsp = '☠',
  precedes = '«',
  extends = '»',
  conceal = '┊',
}
-- Hide buffer when switching to other files
vim.opt.hidden = true
-- Prefer bash for shell-related tasks
vim.opt.shell = '/bin/bash'
-- Disable annoying swapfiles
vim.opt.swapfile = false
-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'
-- Search relative to current file and directory
vim.opt.path = '.,**'
-- Split right by default
vim.opt.splitright = true
-- Always show tabs
vim.opt.showtabline = 2
-- Don't wrap words
vim.opt.wrap = false
-- Show highlight when performing substitutions
vim.opt.inccommand = 'split'
-- Enable mouse coz why not?
vim.opt.mouse = 'nivcr'
-- Use ripgrep instead of grep
vim.opt.grepprg = [[rg --vimgrep --no-heading --smart-case]]

vim.opt.shortmess = vim.opt.shortmess
  + 'a'
  + 'I' -- Disable intro message
  + 'c' -- Don't give |ins-completion-menu| messages

-- Formatting
vim.opt.formatoptions = vim.opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore

-- Pums
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.pumheight = 15
-- Always show sign columns
vim.opt.signcolumn = 'number'
-- Having longer update time leads to noticeable delays and poor UX
vim.opt.updatetime = 250
-- Start scrolling when we're 8 lines below
vim.opt.scrolloff = 8
-- and 15 lines from the side
vim.opt.sidescrolloff = 15
-- Don't show the --INSERT--
vim.opt.showmode = false
-- Enable backups
vim.opt.backup = true
-- Ensure filename uniqueness with //
vim.opt.backupdir = { vim.fn.stdpath('data') .. '/backup//' }
-- Enable persistent undo
vim.opt.undofile = true

vim.opt.wildmenu = true
vim.opt.wildcharm = 26 -- Equivalent of <C-z>
vim.opt.wildmode = { 'longest', 'full' }
vim.opt.wildoptions = 'pum'

-- Number of folds available when starting to edit files
-- Set to 0 all folds closed, 1 some folds closed, 99 no folds closed
vim.opt.foldlevelstart = 99
-- Use indent by default when tresesitter folds are not available
vim.opt.foldmethod = 'indent'
vim.opt.fillchars = {
  diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = ' ', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = '┃', -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}

vim.opt.fillchars:append {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┨',
  vertright = '┣',
  verthoriz = '╋',
}

-- Maximum number of nesting of folds for indend and syntax method
vim.opt.foldnestmax = 4
--Number of screenlines above which a fold can be displayed closed
vim.opt.foldminlines = 2

-- Used when `wrap` is enabled
vim.opt.breakindent = true
-- Make it so long that lines wrap smartly
vim.opt.linebreak = true
vim.opt.showbreak = ' ↳ '

vim.opt.lazyredraw = true

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Prefer dark theme by default if NVIM_BACKGROUND is not set
vim.opt.background = vim.env.NVIM_BACKGROUND or 'dark'

-- Do not highlight on long lines
vim.opt.synmaxcol = 512

-- Use 1 Global statusline
vim.opt.laststatus = 3

-- Coz having `laststatus=3` makes other windows filename not get displayed
vim.opt.winbar = vim.opt.winbar
  + "%{winnr() > 9 ? '󰏁 ':''}"
  + "%{winnr() == 1 ? '󰎥 ':''}"
  + "%{winnr() == 2 ? '󰎨 ':''}"
  + "%{winnr() == 3 ? '󰎫 ':''}"
  + "%{winnr() == 4 ? '󰎲 ':''}"
  + "%{winnr() == 5 ? '󰎯 ':''}"
  + "%{winnr() == 6 ? '󰎴 ':''}"
  + "%{winnr() == 7 ? '󰎷 ':''}"
  + "%{winnr() == 8 ? '󰎺 ':''}"
  + "%{winnr() == 9 ? '󰎽 ':''}"
  + " %{expand('%') == '' ? '[No Name]' : pathshorten(expand('%:~:.'))} "
  -- + '%='
  -- + "%{&modified?' ':''}"
  + "%{&modified?'[+] ':''}"
  + "%{&readonly?' ':''}"
  + "%{&spell?' ¶ ':''}"

-- Use <Space> as the leader key
vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
