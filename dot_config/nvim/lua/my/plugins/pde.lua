return {
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-unimpaired', keys = { 'yo', '[', ']' } },
  { 'tpope/vim-rsi', event = 'InsertEnter' },
  { 'tpope/vim-abolish', event = 'VeryLazy' },
  {
    'mbbill/undotree',
    init = function()
      vim.g.undotree_HighlightChangedWithSign = 0
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
    keys = {
      { '<leader>u', '<Cmd>UndotreeToggle<CR>', desc = 'Undotree Toggle' },
    },
  },
  {
    'kevinhwang91/nvim-fundo',
    event = { 'BufWritePre' },
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require('fundo').install()
    end,
  },
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPost', 'BufNewFile' },
    version = false,
    init = function()
      vim.g.miniindentscope_disable = true
    end,
    config = function()
      require('mini.indentscope').setup {
        draw = {
          delay = 10,
        },
        symbol = '│',
        options = { try_as_border = true },
      }
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPost', 'BufNewFile' },
    version = false,
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          coco = { pattern = '%f[%w]()COCO()%f[%W]', group = 'Debug' },
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = false,
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
      }
    end,
    keys = {
      {
        'yoH',
        function()
          local utils = require('my.utils')
          local chunk_mod = require('hlchunk.mods.chunk') {}

          vim.b.hlindent_t_state = not vim.b.hlindent_t_state

          if vim.b.hlindent_t_state then
            chunk_mod:enable()
            utils.info('enabled hlchunk', 'Toggle')
          else
            chunk_mod:disable()
            utils.warn('disabled hlchunk', 'Toggle')
          end
        end,
        desc = 'Toggle hlchunk',
      },
    },
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      keymaps = {
        replace = '<Space>R',
      },
      startInInsertMode = false,
    },
    cmd = 'GrugFar',
    keys = {
      { '<leader>S', '<Cmd>GrugFar<CR>', desc = 'GrugFar' },
    },
  },
  { 'tversteeg/registers.nvim', event = 'VeryLazy' },
  {
    'gbprod/yanky.nvim',
    event = { 'BufReadPost' },
    keys = { 'y', '<Left>', '<Right>', '<leader>yy' },
    config = function()
      require('yanky').setup {
        ring = {
          history_length = 100,
          storage = 'shada',
          sync_with_numbered_registers = true,
          cancel_event = 'update',
          ignore_registers = { '_' },
          update_register_on_cycle = false,
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        preserve_cursor_position = {
          enabled = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
      }

      vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

      vim.keymap.set('n', '<leader>yy', '<Cmd>YankyRingHistory<CR>')

      -- The unimpaired y feels awkard to press when using colemak layout
      vim.keymap.set('n', '<Left>', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', '<Right>', '<Plug>(YankyNextEntry)')
    end,
  },
  {
    'yujinyuz/very-magic-slash.nvim',
    event = 'VeryLazy',
    opts = {},
    dev = true,
  },
  {
    'yujinyuz/gitpad.nvim',
    dev = true,
    config = function()
      require('gitpad').setup {
        dir = '~/Sync/notes/gitpad',
        border = 'rounded',
        on_attach = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<Cmd>silent! wq<CR>', { noremap = true, silent = true })
          vim.opt_local.textwidth = 100
        end,
      }
    end,
    keys = {
      {
        '<leader>pp',
        function()
          require('gitpad').toggle_gitpad()
        end,
        desc = 'gitpad project',
      },
      {
        '<leader>pb',
        function()
          require('gitpad').toggle_gitpad_branch()
        end,
        desc = 'gitpad branch',
      },
      {
        '<leader>pn',
        function()
          local date_filename = 'daily-' .. os.date('%Y-%m-%d.md')
          require('gitpad').toggle_gitpad { filename = date_filename, title = 'Daily Notes' }
        end,
        desc = 'gitpad daily notes',
      },
      {
        '<leader>pf',
        function()
          local filename = vim.fn.bufname()
          if filename == '' then
            vim.notify('empty bufname')
            return
          end
          filename = filename .. '.md'
          require('gitpad').toggle_gitpad { filename = filename }
        end,
        desc = 'gitpad per file notes',
      },
    },
  },
}
