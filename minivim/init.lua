vim.opt.packpath = {}
vim.opt.runtimepath = {
  "~/.neovim",
  "$VIMRUNTIME",
}

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.title = true
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
vim.opt.hidden = true
vim.opt.shell = '/bin/bash'
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.path = '.,**'
vim.opt.splitright = true
vim.opt.showtabline = 2
vim.opt.wrap = false
vim.opt.inccommand = 'split'
vim.opt.mouse = 'nicr'
vim.opt.grepprg = [[rg --vimgrep --no-heading --smart-case]]
vim.opt.shortmess = vim.opt.shortmess
  + 'a'
  + 'I' -- Disable intro message
  + 'c' -- Don't give |ins-completion-menu| messages
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
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.pumheight = 15
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 100
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.wildcharm = 26 -- Equivalent of <C-z>
vim.opt.wildmode = { 'longest', 'full' }
vim.opt.wildoptions = 'pum'
vim.opt.foldlevelstart = 99
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
vim.opt.foldnestmax = 4
vim.opt.foldminlines = 2
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = ' ↳ '
vim.opt.lazyredraw = true
vim.opt.termguicolors = true
vim.opt.synmaxcol = 512
vim.opt.laststatus = 3
vim.g.mapleader = ' '


---- Maps
vim.keymap.set('n', '<C-p>', ':e **/', {})
