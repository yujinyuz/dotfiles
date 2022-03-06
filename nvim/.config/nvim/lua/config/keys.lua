local utils = require('utils')

vim.opt.timeoutlen = 300

local wk = require('which-key')

wk.setup {
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
}

-- Prevent accidentally opening ex mode
vim.keymap.set('n', 'Q', '"_')

-- Create new file
vim.keymap.set('n', '<leader>fn', [[:e %:h<C-z>]])

-- Buffer Switch
vim.keymap.set('n', '<BS>', '<C-^>')

-- Resize splits with Shift + Arrow Keys
vim.keymap.set('n', '<S-Up>', '<C-w>+')
vim.keymap.set('n', '<S-Down>', '<C-w>-')
vim.keymap.set('n', '<S-Left>', '<C-w><')
vim.keymap.set('n', '<S-Right>', '<C-w>>')
vim.keymap.set('n', '<leader>=', '<C-w>=')

-- Windows
vim.keymap.set('n', '<C-j>', '<C-w>w')
vim.keymap.set('n', '<C-k>', '<C-w>W')

-- Navigate to splits with arrow keys
vim.keymap.set('n', '<Left>', '<C-w>h')
vim.keymap.set('n', '<Right>', '<C-w>l')
vim.keymap.set('n', '<Up>', '<C-w>k')
vim.keymap.set('n', '<Down>', '<C-w>j')

-- Smooth scroll
vim.keymap.set('n', '<C-y>', '3<C-y>')
vim.keymap.set('n', '<C-e>', '3<C-e>')

-- Use Alt for moving lines up/down
vim.keymap.set('n', '<M-j>', [[mz:m+<CR>`z]], { silent = true })
vim.keymap.set('n', '<M-k>', [[mz:m-2<CR>`z]], { silent = true })
vim.keymap.set('v', '<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]], { silent = true })
vim.keymap.set('v', '<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]], { silent = true })

-- Command-line like navigation
vim.keymap.set('c', '<C-j>', '<C-n>')
vim.keymap.set('c', '<C-k>', '<C-p>')

-- Don't lose selection when shifting sidewards
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<M-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<M-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<M-k>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<M-l>', [[<C-\><C-n><C-w>l]])

-- Persistent highlights
vim.keymap.set('n', '<leader>ll', [[<Cmd>call matchadd('Visual', '\%'.line('.').'l')<CR>]], { silent = true })
vim.keymap.set('n', '<leader>lc', [[<Cmd>call clearmatches()<CR>]], { silent = true })

vim.keymap.set('c', 'w!!', [[:lua require('utils').sudo_write()<CR>]])

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>')

vim.keymap.set('n', '<localleader>b', '<Cmd>Vista!!<CR>')

vim.keymap.set('n', '<A-i>', '<Cmd>lua require("FTerm").toggle()<CR>')

vim.keymap.set('t', '<A-i>', '<Cmd>lua require("FTerm").toggle()<CR>')

vim.keymap.set('x', '<leader>h0', ':<c-u>HSHighlight 0<CR>')
vim.keymap.set('x', '<leader>h1', ':<c-u>HSHighlight 1<CR>')
vim.keymap.set('x', '<leader>h2', ':<c-u>HSHighlight 2<CR>')
vim.keymap.set('x', '<leader>h3', ':<c-u>HSHighlight 3<CR>')
vim.keymap.set('x', '<leader>h4', ':<c-u>HSHighlight 4<CR>')
vim.keymap.set('x', '<leader>h5', ':<c-u>HSHighlight 5<CR>')
vim.keymap.set('x', '<leader>h6', ':<c-u>HSHighlight 6<CR>')
vim.keymap.set('x', '<leader>h7', ':<c-u>HSHighlight 7<CR>')
vim.keymap.set('x', '<leader>h8', ':<c-u>HSHighlight 8<CR>')
vim.keymap.set('x', '<leader>h9', ':<c-u>HSHighlight 9<CR>')

vim.keymap.set('n', '<space>cu', function()
  local number = math.random(math.pow(2, 127) + 1, math.pow(2, 128))
  return 'i' .. string.format('%.0f', number)
end, {
  expr = true,
})

vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', '<C-p>', ':e **/')

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
        require('persistence').load { last = true }
      end,
      'Restore Last Session',
    },
    s = {
      function()
        require('persistence').load {}
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
        require('telescope.builtin').lsp_document_symbols {
          symbols = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module' },
        }
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
