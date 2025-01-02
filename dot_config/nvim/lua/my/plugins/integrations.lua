return {
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
    keys = {
      {
        '<C-l>',
        function()
          require('luasnip').expand()
        end,
        mode = 'i',
      },
    },
    -- build = 'make install_jsregexp',
    dependencies = 'rafamadriz/friendly-snippets',
  },
  {
    'stevearc/conform.nvim',
    event = 'BufReadPost',
    opts = {
      formatters = {
        kulala = {
          command = 'kulala-fmt',
          args = { '$FILENAME' },
          stdin = false,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'eslint_d' },
        -- javascript = { 'eslint_d', 'prettierd' },
        python = { 'ruff_format', 'ruff_fix', 'ruff_organize_imports' },
        fish = { 'fish_indent' },
        json = { 'jq' },
        jsonc = { 'fixjson' },
        htmldjango = { 'djlint' },
        toml = { 'taplo' },
        http = { 'kulala' },
        go = { 'goimports', 'gofmt', lsp_format = 'fallback' },
        templ = { 'templ' },
      },
      format_on_save = function(bufnr)
        if not require('my.format').is_enabled(bufnr) then
          return nil
        end

        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        fish = { 'fish' },
        -- Used ruff
        -- python = { 'ruff' },
        dockerfile = { 'hadolint' },
        htmldjango = { 'djlint' },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { 'G', mode = 'c' },
      { '<leader>gs', '<Cmd>Git<CR>', desc = 'Git' },
      { '<leader>gv', '<Cmd>Gvdiffsplit<CR>', desc = 'Git' },
    },
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<Cmd>Neogit<CR>', desc = 'Neogit' },
    },
    opts = {
      kind = 'split_above',
      integrations = { diffview = true },
      disable_commit_confirmation = true,
      sections = {
        untracked = {
          folded = true,
        },
      },
      mappings = {
        status = {
          ['='] = 'Toggle',
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
  },
  {
    'ruifm/gitlinker.nvim',
    config = true,
    keys = {
      { '<leader>gy', mode = { 'n', 'v' } },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      local gs = require('gitsigns')
      return {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gs.nav_hunk('next')
              vim.schedule(function()
                gs.preview_hunk_inline()
              end)
            end
          end, { buffer = bufnr, desc = 'Next Hunk' })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gs.nav_hunk('prev')
              vim.schedule(function()
                gs.preview_hunk_inline()
              end)
            end
          end, { buffer = bufnr, desc = 'Prev Hunk' })

          -- Actions
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk)
          vim.keymap.set('v', '<leader>hs', function()
            gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
          end)
          vim.keymap.set('v', '<leader>hr', function()
            gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
          end)
          vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
          vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
          vim.keymap.set('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end)

          -- Commented this out since it conflicts with some of my mappings that starts
          -- with <leader>t. Will come back to this later
          vim.keymap.set('n', '<leader>htb', gs.toggle_current_line_blame)
          vim.keymap.set('n', '<leader>htd', gs.toggle_deleted)
          vim.keymap.set('n', '<leader>hd', gs.diffthis)
          vim.keymap.set('n', '<leader>hD', function()
            gs.diffthis('~')
          end)

          vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true })
        end,
      }
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {
        '<leader>D',
        function()
          vim.cmd('DBUIToggle')
        end,
      },
    },
  },
}
