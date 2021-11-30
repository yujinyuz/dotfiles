local opt = vim.opt

-- Shift 2 spaces when pressing tab
opt.tabstop = 2
-- Shift 2 spaces when pressing < or >
opt.shiftwidth = 2
-- Round indent spacing with the multiples of shiftwidth
opt.shiftround = true
-- Use spaces instead of tabs
opt.expandtab = true
-- Indents
opt.autoindent = true
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
opt.listchars = {
  tab = '→ ',
  trail = '·',
  space = '·',
  eol = '↲',
  nbsp = '☠',
  precedes = '«',
  extends = '»',
  conceal = '┊',
}
-- Hide buffer when switching to other files
opt.hidden = true
-- Prefer bash for shell-related tasks
opt.shell = '/bin/bash'
-- Disable annoying swapfiles
opt.swapfile = false
-- Use system clipboard
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
opt.grepprg = [[rg --vimgrep --no-heading --smart-case]]

opt.shortmess = opt.shortmess
  + 'a'
  + 'I' -- Disable intro message
  + 'c' -- Don't give |ins-completion-menu| messages

-- Formatting
opt.formatoptions = opt.formatoptions
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
opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
opt.pumheight = 15
-- Always show sign columns
opt.signcolumn = 'yes'
-- Having longer update time leads to noticeable delays and poor UX
opt.updatetime = 250
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
opt.backupdir = vim.fn.stdpath('data') .. '/backup//'
-- Enable persistent undo
opt.undofile = true

opt.wildmenu = true
opt.wildcharm = 26 -- Equivalent of <C-z>
opt.wildmode = { 'longest', 'full' }
opt.wildoptions = 'pum'

-- Number of folds available when starting to edit files
-- Set to 0 all folds closed, 1 some folds closed, 99 no folds closed
opt.foldlevelstart = 1
-- Use indend by default when tresesitter folds are not available
opt.foldmethod = 'indent'
-- Display better folds
opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
opt.fillchars = { fold = " ", vert = "|" }

-- Maximum number of nesting of folds for indend and syntax method
opt.foldnestmax = 4
--Number of screenlines above which a fold can be displayed closed
opt.foldminlines = 2


-- Used when `wrap` is enabled
opt.breakindent = true
-- Make it so long that lines wrap smartly
opt.showbreak = string.rep(' ', 3)
opt.linebreak = true

opt.lazyredraw = true

-- Enable 24-bit RGB color
opt.termguicolors = true

-- Do not highlight on long lines
opt.synmaxcol = 512

-- opt.switchbuf = 'usetab' -- try to reuse windows/tabs when switching buffers
