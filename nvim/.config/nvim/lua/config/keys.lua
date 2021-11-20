local nnoremap = vim.keymap.nnoremap
local cnoremap = vim.keymap.cnoremap
local xnoremap = vim.keymap.xnoremap
local tnoremap = vim.keymap.tnoremap
local inoremap = vim.keymap.inoremap
local nmap = vim.keymap.nmap
local vmap = vim.keymap.vmap

local utils = require('utils')

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
  triggers_blacklist = {
    c = { 'w' },
    n = { '`' },
  },
})

-- Prevent accidentally opening ex mode
nnoremap({ 'Q', '"_' })

-- Create new file
nnoremap({ '<leader>fn', [[:e %:h<C-z>]] })

-- Remove highlights
nnoremap({ '<C-l>', [[<Cmd>nohlsearch<CR><Cmd>diffupdate<CR><C-l>]], silent = true })
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

cnoremap({ 'w!!', [[:lua require('utils').sudo_write()<CR>]] })

-- Make undoable
inoremap({ '<C-w>', '<C-g>u<C-w>' })
inoremap({ '<C-u>', '<C-g>u<C-u>' })

-- nvim-tree
nnoremap({ '<C-n>', '<Cmd>NvimTreeToggle<CR>' })

-- nnoremap({'<leader><Space>', require('config.telescope').project_files})

wk.register({
  [' '] = 'Find Files',
  ['/'] = {
    'Browse Files',
  },
  ['.'] = {
    'Browse Files Related to Current File',
  },
  [']'] = {
    function()
      require('telescope.builtin').tags({ only_sort_tags = true })
    end,
    'Open tags',
  },
  ['2'] = { '<Cmd>ZenMode<CR>', 'Zen Mode' },
  ['3'] = { '<Cmd>Twilight<CR>', 'Twilight Mode' },
  b = {
    name = '+buffer',
    ['1'] = { '<Cmd>%bd|e#|bd#<CR>', 'Delete other buffers except this one' },
    b = { '<Cmd>Telescope buffers<CR>', 'Buffer List' },
  },
  f = {
    name = '+file',
    t = { '<Cmd>NvimTreeToggle<CR>', 'Toggle NvimTree' },
    n = { 'Create new file relative to current file' },
    f = { '<Cmd>Telescope find_files<CR>', 'Find Files *Telescope*' },
    x = { ':update<CR>|:source<CR>', 'Save and Execute Current File' },
  },
  F = { 'Live Grep' },
  g = {
    name = '+git',
    f = { '<Cmd>G<CR>', 'Fugitive' },
    g = { '<Cmd>Neogit<CR>', 'NeoGit' },
    c = { '<Cmd>Telescope git_commits<CR>', 'commits' },
    b = { '<Cmd>Telescope git_branches<CR>', 'branches' },
    s = { '<Cmd>G<CR>', 'Fugitive' },
    -- s = { '<Cmd>Telescope git_status<CR>', 'status' },
    d = { '<Cmd>DiffviewOpen<Cr>', 'DiffView' },
    y = { 'Show Permalink' },
  },
  h = {
    name = '+help',
    t = { '<<Cmd>Telescope builtin<CR>', 'Telescope' },
    c = { '<Cmd>Telescope commands<CR>', 'Commands' },
    h = { '<Cmd>Telescope help_tags<CR>', 'Help Pages' },
    l = { '<Cmd>TSHighlightCapturesUnderCursor<CR>', 'Highlight Groups under cursor' },
    p = {
      name = '+packer',
      p = { '<Cmd>PackerSync<CR>', 'Sync' },
      f = { '<Cmd>PackerProfile<CR>', 'Profile' },
      s = { '<Cmd>PackerStatus<CR>', 'Status' },
      i = { '<Cmd>PackerInstall<CR>', 'Install' },
      c = { '<Cmd>PackerCompile profile=true<CR>', 'Compile' },
    },
  },
  l = {},
  o = {
    name = '+open',
    t = { '<Cmd>lua require("FTerm").toggle()<CR>', 'Toggle Terminal' },
  },
  p = {
    name = '+project',
    p = {
      function()
        require('workbench').toggle_project_workbench()
      end,
      'Project Workbench',
    },
    b = {
      function()
        require('workbench').toggle_branch_workbench()
      end,
      'Branch Workbench',
    },
  },
  q = {
    name = '+quit/session',
    q = { '<Cmd>q!<CR>', 'Quick quit without saving' },
    a = { '<Cmd>qa!<CR>', 'Quit all without saving' },
  },
  r = {
    n = { 'Rename *Treesitter*' },
  },
  s = {
    name = '+search',
    g = { '<Cmd>Telescope live_grep<CR>', 'Grep' },
    b = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'Buffer' },
    s = {
      function()
        require('telescope.builtin').lsp_document_symbols({
          symbols = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module' },
        })
      end,
      'Goto Symbol',
    },
  },
  S = { '<Cmd>lua require("spectre").open()<CR>', 'Spectre Search' },
  u = { '<Cmd>UndotreeToggle<CR>', 'Undotree Toggle' },
  w = { '<Cmd>update<CR>', 'Write File *only when updated*' },
  x = {
    name = '+errors',
    x = { '<Cmd>TroubleToggle<CR>', 'Trouble' },
    w = { '<Cmd>TroubleWorkspaceToggle<CR>', 'Workspace Trouble' },
    d = { '<Cmd>TroubleDocumentToggle<CR>', 'Document Trouble' },
    t = { '<Cmd>TodoTrouble<CR>', 'Todo Trouble' },
    T = { '<Cmd>TodoTelescope<CR>', 'Todo Telescope' },
    l = { '<Cmd>lopen<CR>', 'Open Location List' },
    q = { '<Cmd>copen<CR>', 'Open Quickfix List' },
  },
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
    name = '+switch',
    b = { '<Cmd>GitBlameToggle<CR>', 'Toggle Git Blame' },
    f = { require('config.lsp.formatting').toggle, 'Format on Save' },
    l = { '<Cmd>IndentBlanklineToggle<CR>', 'Toggle Indent Lines' },
    n = {
      function()
        utils.toggle('number')
      end,
      'Line Numbers',
    },
    r = {
      function()
        utils.toggle('relativenumber')
      end,
      'Relative Numbers',
    },
    s = {
      function()
        utils.toggle('spell')
      end,
      'Spelling',
    },
    w = {
      function()
        utils.toggle('wrap')
      end,
      'Word Wrap',
    },
  },
}

wk.register(text_objects, { prefix = '', mode = 'o' })
wk.register(switches, { prefix = 'y', mode = 'n' })
