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
vim.opt.list = true
vim.opt.listchars = {
  tab = '▷⋯', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail = '·',
  -- eol = '↲',
  -- eol = '↴',
  nbsp = '☠',
  precedes = '…',
  extends = '…',
  conceal = '┊',
}
-- Hide buffer when switching to other files
vim.opt.hidden = true
-- Prefer sh for shell-related tasks
vim.opt.shell = 'sh'
-- Disable annoying swapfiles
vim.opt.swapfile = false
-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'
-- Search relative to current file and directory
vim.opt.path = '.,**'
-- Split right by default
vim.opt.splitright = true
-- Split below by default
vim.opt.splitbelow = true
-- Always show tabs
vim.opt.showtabline = 2
-- Don't wrap words
vim.opt.wrap = false
-- Show highlight when performing substitutions
vim.opt.inccommand = 'split'
-- Enable mouse coz why not?
vim.opt.mouse = 'nivcr'
-- Use ripgrep instead of grep
vim.opt.grepprg = 'rg --vimgrep --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

vim.opt.shortmess = vim.opt.shortmess
  + 'a' -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
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
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.pumheight = 15
-- Always show sign columns
vim.opt.signcolumn = 'number'
-- Having longer update time leads to noticeable delays and poor UX
vim.opt.updatetime = 250
-- Start scrolling when we're 10 lines below
vim.opt.scrolloff = 10
-- and 3 lines from the side
vim.opt.sidescrolloff = 3
-- Dislay --INSERT--
vim.opt.showmode = true
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
  fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
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
vim.opt.showbreak = ' ↪ '

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Prefer dark theme by default if NVIM_BACKGROUND is not set
vim.opt.background = vim.env.NVIM_BACKGROUND or 'dark'

-- Do not highlight on long lines
vim.opt.synmaxcol = 512

-- Use 1 Global statusline
vim.opt.laststatus = 3

-- Having `laststatus=3` makes other windows filename not get displayed
-- so we will simulate the filename via winbar
vim.opt.winbar = vim.opt.winbar
  + ' '
  + "%{expand('%') == '' ? '[No Name]' : pathshorten(expand('%:~:.'))} "
  + '%m '
  + '%{&readonly ? "󰍁 ":""}'

-- Only show tabline if there are more than 1 tab
vim.opt.showtabline = 1

-- Automatically execute .nvim.lua files
vim.opt.exrc = true

-- Prevent moving windows around
vim.opt.splitkeep = 'screen'

-- Always ask for confirmation when closing unsaved buffers
vim.opt.confirm = true

-- Use <Space> as the leader key
vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Diagnostic symbols in the sign column (gutter)
vim.fn.sign_define('DiagnosticSignError', { text = '✖', texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '➤', texthl = 'DiagnosticSignHint', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠', texthl = 'DiagnosticSignWarn', numhl = '' })

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = '●' },
  severity_sort = true,
  float = {
    source = true,
  },
}
