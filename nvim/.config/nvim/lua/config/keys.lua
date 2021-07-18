local nnoremap = vim.keymap.nnoremap
local cnoremap = vim.keymap.cnoremap
local xnoremap = vim.keymap.xnoremap
local tnoremap = vim.keymap.tnoremap
local nmap = vim.keymap.nmap
local vmap = vim.keymap.vmap

vim.opt.timeoutlen = 300

local wk = require('which-key')

wk.setup({
  -- show_help = false,
  -- triggers = "auto",
  plugins = {
    spelling = true,
  },
  key_labels = {
    ['<leader>'] = 'SPC',
    ['<space>'] = 'SPC',
    ['<CR>'] = 'RET',
    ['<TAB>'] = 'TAB',
  },
  window = { padding = { 0, 0, 0, 0 } },
  layout = { height = { min = 1, max = 10 } },
})

-- Remove highlights
nnoremap({
  '<C-l>',
  -- '<Esc>',
  [[<Cmd>nohlsearch<CR><Cmd>diffupdate<CR><C-l>]],
  silent = true,
})
-- Make Y work like other upcase commands
nnoremap({ 'Y', 'y$' })
-- Buffer Switch
nnoremap({ '<BS>', '<C-^>' })
-- Resize splits with arrows
nnoremap({ '<Up>', '<C-w>+' })
nnoremap({ '<Down>', '<C-w>-' })
nnoremap({ '<Left>', '<C-w><' })
nnoremap({ '<Right>', '<C-w>>' })
nnoremap({ '<leader>=', '<C-w>=' })

-- Windows
nnoremap({ '<C-j>', '<C-w>w' })
nnoremap({ '<C-k>', '<C-w>W' })

-- Smooth scroll
nnoremap({ '<C-y>', '3<C-y>' })
nnoremap({ '<C-e>', '3<C-e>' })

-- Use Alt for moving lines up/down
nmap({ '<M-j>', [[mz:m+<CR>`z]], silent = true })
nmap({ '<M-k>', [[mz:m-2<CR>`z]], silent = true })
vmap({ '<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]], silent = true })
vmap({ '<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]], silent = true })

-- Command-line like navigation
cnoremap({ '<C-j>', '<C-n>' })
cnoremap({ '<C-k>', '<C-p>' })

-- Don't lose selection when shifting sidewards
xnoremap({ '<', '<gv' })
xnoremap({ '>', '>gv' })

tnoremap({ '<Esc>', [[<C-\><C-n>]] })
tnoremap({ '<M-h>', [[<C-\><C-n><C-w>h]] })
tnoremap({ '<M-j>', [[<C-\><C-n><C-w>j]] })
tnoremap({ '<M-k>', [[<C-\><C-n><C-w>k]] })
tnoremap({ '<M-l>', [[<C-\><C-n><C-w>l]] })

-- Persistent highlights
nnoremap({ '<leader>ll', [[<Cmd>call matchadd('Visual', '\%'.line('.').'l')<CR>]], silent = true })
nnoremap({ '<leader>lc', [[<Cmd>call clearmatches()<CR>]], silent = true })

wk.register({
  [' '] = 'Find Files',
  ['/'] = { "<Cmd>lua require('lir.float').toggle('.')<CR>", 'Browse Files' },
  ['.'] = { "<Cmd>lua require('lir.float').toggle()<CR>", 'Browse Files Related to Current File' },
  ['2'] = { '<Cmd>ZenMode<CR>', 'Zen Mode' },
  ['3'] = { 'Twilight Mode' },
  b = {
    name = '+buffer',
    ['1'] = { '<Cmd>%bd|e#|bd#<CR>', 'Delete other buffers except this one' },
    b = { '<Cmd>Telescope buffers<CR>', 'Buffer List' },
  },
  d = { '"_d', 'Blackhole Delete' },
  f = {
    name = '+file',
    n = { ':e %:h<C-z>', 'Create new file relative to current file' },
    f = { '<Cmd>Telescope find_files<CR>', 'Find Files *Telescope*' },
  },
  g = {
    name = '+git',
    g = { '<Cmd>Neogit<CR>', 'NeoGit' },
    s = { '<Cmd>G<CR>', 'Fugtiive' },
    y = { 'Show Permalink' },
  },
  h = {
    name = '+hunks',
  },
  l = {},
  F = 'Live Grep',
  o = {
    name = '+open',
    t = { '<Cmd>lua require("FTerm").toggle()<CR>', 'Toggle Terminal' },
    u = { '<Cmd>UndotreeToggle<CR>', 'Undotree Toggle' },
  },
  p = {
    name = '+project',
    p = { '<Cmd>lua require("workbench").toggle_project_workbench()<CR>', 'Project Workbench' },
    b = { '<Cmd>lua require("workbench").toggle_branch_workbench()<CR>', 'Branch Workbench' },
  },
  q = {
    name = '+quit/session',
    ['!'] = { '<Cmd>qa!<CR>', 'Quit without saving' },
    q = { '<Cmd>q<CR>', 'Quit quick' },
    a = { '<Cmd>qa!<CR>', 'Quit all without saving' },
  },
  r = {
    n = { 'Rename *Treesitter*' },
  },
  S = { '<Cmd>lua require("spectre").open()<CR>', 'Spectre Search' },
  w = { '<Cmd>update<CR>', 'Write File *only when updated*' },
  x = { ':update<CR>|:source<CR>', 'Save and Source Current File' },
}, {
  prefix = '<leader>',
  mode = 'n',
})

local text_objects = {
  ['af'] = 'Around Function',
  ['ac'] = 'Around Class',
}

local switches = {
  o = {
    l = { '<Cmd>IndentBlanklineToggle<CR>', 'Toggle Indent Lines' },
    b = { '<Cmd>GitBlameToggle<CR>', 'Toggle Git Blame' },
  },
}

wk.register(text_objects, { mode = 'o', prefix = '' })

wk.register(switches, { prefix = 'y', mode = 'n' })

wk.register({
  ['<C-n>'] = { '<Cmd>NvimTreeToggle<CR>', 'Toggle Nvim Tree' },
}, { prefix = '', mode = 'n' })
