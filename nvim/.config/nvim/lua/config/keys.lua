local nnoremap = vim.keymap.nnoremap
local cnoremap = vim.keymap.cnoremap
local xnoremap = vim.keymap.xnoremap
local vnoremap = vim.keymap.xnoremap
local tnoremap = vim.keymap.tnoremap
local inoremap = vim.keymap.inoremap
local nmap = vim.keymap.nmap
local vmap = vim.keymap.vmap
local xmap = vim.keymap.xmap
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

-- Buffer Switch
nnoremap({ '<BS>', '<C-^>' })

-- Resize splits with Shift + Arrow Keys
nnoremap({ '<S-Up>', '<C-w>+' })
nnoremap({ '<S-Down>', '<C-w>-' })
nnoremap({ '<S-Left>', '<C-w><' })
nnoremap({ '<S-Right>', '<C-w>>' })
nnoremap({ '<leader>=', '<C-w>=' })

-- Windows
nnoremap({ '<C-j>', '<C-w>w' })
nnoremap({ '<C-k>', '<C-w>W' })

-- Navigate to splits with arrow keys
nnoremap({ '<Left>', '<C-w>h' })
nnoremap({ '<Right>', '<C-w>l' })
nnoremap({ '<Up>', '<C-w>k' })
nnoremap({ '<Down>', '<C-w>j' })

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

-- nvim-tree
nnoremap({ '<C-n>', '<Cmd>NvimTreeToggle<CR>' })

nnoremap({ '<localleader>b', '<Cmd>Vista!!<CR>' })

nnoremap({
  '<A-i>',
  '<Cmd>lua require("FTerm").toggle()<CR>',
})

tnoremap({
  '<A-i>',
  '<Cmd>lua require("FTerm").toggle()<CR>',
})

xnoremap({ '<leader>h0', ':<c-u>HSHighlight 0<CR>' })
xnoremap({ '<leader>h1', ':<c-u>HSHighlight 1<CR>' })
xnoremap({ '<leader>h2', ':<c-u>HSHighlight 2<CR>' })
xnoremap({ '<leader>h3', ':<c-u>HSHighlight 3<CR>' })
xnoremap({ '<leader>h4', ':<c-u>HSHighlight 4<CR>' })
xnoremap({ '<leader>h5', ':<c-u>HSHighlight 5<CR>' })
xnoremap({ '<leader>h6', ':<c-u>HSHighlight 6<CR>' })
xnoremap({ '<leader>h7', ':<c-u>HSHighlight 7<CR>' })
xnoremap({ '<leader>h8', ':<c-u>HSHighlight 8<CR>' })
xnoremap({ '<leader>h9', ':<c-u>HSHighlight 9<CR>' })

nnoremap({
  '<space>cu',
  function()
    local number = math.random(math.pow(2, 127) + 1, math.pow(2, 128))
    return 'i' .. string.format('%.0f', number)
  end,
  expr = true,
})

-- nnoremap({
--   '<leader><Space>',
--   function()
--     utils.warn([[Find Files deprecated. Use one of the following: <leader>(n, oo, ff)]], 'Muscle Memory Training')
--   end,
-- })

nmap({ 'ga', '<Plug>(EasyAlign)' })
xmap({ 'ga', '<Plug>(EasyAlign)' })

wk.register({
  [' '] = 'Find Files',
  ['/'] = {
    'Browse Files',
  },
  ['.'] = {
    'Browse Files Related to Current File',
  },
  [']'] = {
    'Open tags',
  },
  ['2'] = { '<Cmd>ZenMode<CR>', 'Zen Mode' },
  ['3'] = { '<Cmd>Twilight<CR>', 'Twilight Mode' },
  b = {
    name = '+buffer',
    ['1'] = { '<Cmd>%bd|e#|bd#<CR>', 'Delete other buffers except this one' },
    b = { 'Buffer List' },
    d = { '<Cmd>BDelete this<CR>', 'Buffer Delete' },
    t = { '<Cmd>Vista!!<CR>', 'Buffer Tags' },
    o = { '<Cmd>SymbolsOutline<CR>', 'Symbols Outline' },
  },
  f = {
    name = '+file',
    t = { '<Cmd>NvimTreeToggle<CR>', 'Toggle NvimTree' },
    n = { 'Create new file relative to current file' },
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
    v = { '<Cmd>Gvdiffsplit<CR>', 'Vertical Diff Split' },
    h = {
      name = '+hunk',
      s = { 'Hunk Stage' },
      S = { 'Hunk Stage Buffer' },
      u = { 'Hunk Undo Stage' },
      U = { 'Hunk Reset Buffer Index' },
      r = { 'Hunk Reset' },
      R = { 'Hunk Reset Buffer' },
      p = { 'Hunk Preview' },
      b = { 'Hunk Blame Line' },
      t = {
        function()
          require('gitsigns').setqflist()
        end,
        'Hunk Trouble',
      },
    },
  },
  h = {
    name = '+help',
    t = { '<<Cmd>Telescope builtin<CR>', 'Telescope' },
    c = { '<Cmd>Telescope commands<CR>', 'Commands' },
    h = { '<Cmd>Telescope help_tags<CR>', 'Help Pages' },
    -- l = { '<Cmd>TSHighlightCapturesUnderCursor<CR>', 'Highlight Groups under cursor' },
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
    o = { 'Open Files' },
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
    l = {
      function()
        require('persistence').load({ last = true })
      end,
      'Restore Last Session',
    },
    s = {
      function()
        require('persistence').load({})
      end,
      'Restore Session',
    },
    d = {
      function()
        require('persistence').stop()
      end,
      'Stop Current Session',
    },
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
  Z = { [[<cmd>lua require("zen-mode").reset()<cr>]], 'Zen Mode' },
  z = { [[<cmd>ZenMode<cr>]], 'Zen Mode' },
}, {
  prefix = '<leader>',
  mode = 'n',
})

local text_objects = {
  ['af'] = 'Around Function',
  ['ac'] = 'Around Class',
  ['ih'] = 'Inside Hunk',
}

local switches = {
  o = {
    name = '+switch',
    b = {
      function()
        local config = require('gitsigns.config').config

        if not config.signcolumn then
          utils.info('enabled gitsigns', 'Toggle')
        else
          utils.info('disabled gitsigns', 'Toggle')
        end

        vim.cmd([[
          Gitsigns toggle_current_line_blame |
          Gitsigns toggle_signs |
          Gitsigns toggle_linehl |
          Gitsigns toggle_word_diff
        ]])
      end,
      'Toggle Git Signs',
    },
    d = {
      function()
        require('nvim-biscuits').toggle_biscuits()
      end,
      'Toggle Biscuits Debug',
    },
    f = { require('config.lsp.formatting').toggle, 'Format on Save' },
    l = { '<Cmd>IndentBlanklineToggle<CR>', 'Toggle Indent Lines' },
    n = {
      function()
        utils.toggle('number')
      end,
      'Toggle Line Numbers',
    },
    r = {
      function()
        utils.toggle('relativenumber')
      end,
      'Toggle Relative Numbers',
    },
    s = {
      function()
        utils.toggle('spell')
      end,
      'Toggle Spelling',
    },
    w = {
      function()
        utils.toggle('wrap')

        -- TODO: Replace with
        -- https://github.com/wincent/wincent/blob/a4e5d0/aspects/nvim/files/.config/nvim/plugin/mappings/normal.lua#L38-L40
        if vim.wo.wrap then
          vim.cmd([[
            nnoremap <expr> j (v:count > 4 ? "m'" . v:count . 'j' : 'gj')
            nnoremap <expr> k (v:count > 4 ? "m'" . v:count . 'k' : 'gk')
          ]])
        else
          vim.cmd([[
            unmap j
            unmap k
          ]])
        end
      end,
      'Toggle Word Wrap',
    },
  },
}

wk.register(text_objects, { prefix = '', mode = 'o' })
wk.register(switches, { prefix = 'y', mode = 'n' })
-- wk.register({
--   h = {
--     name = '+highlight',
--     q = { ':<c-u>HSHighlight 1<CR>' },
--     w = { ':<c-u>HSHighlight 2<CR>' },
--   },
-- }, {
--   prefix = '<leader>',
--   mode = 'v',
-- })
