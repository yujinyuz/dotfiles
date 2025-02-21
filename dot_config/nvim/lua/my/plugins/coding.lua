return {
  {
    'andymass/vim-matchup',
    enabled = false,
    event = 'BufReadPost',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
      vim.g.matchup_surround_enabled = 1
    end,
    opts = {},
    config = function(_, opts)
      local ok, cmp = pcall(require, 'cmp')

      -- https://github.com/hrsh7th/nvim-cmp/issues/1940
      if ok then
        cmp.event:on('menu_opened', function()
          vim.b.matchup_matchparen_enabled = false
        end)
        cmp.event:on('menu_closed', function()
          vim.b.matchup_matchparen_enabled = true
        end)
      end
      require('match-up').setup(opts)
    end,
  },
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    'danymat/neogen',
    cmd = { 'Neogen' },
    opts = {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'reST',
          },
        },
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = { debug = true },
    keys = {
      {
        '<leader>cch',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.fzflua').pick(actions.help_actions())
        end,
        mode = { 'n', 'x' },
      },
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        mode = 'n',
      },
      {
        '<leader>ccp',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.fzflua').pick(actions.prompt_actions())
        end,
        mode = { 'n', 'x' },
      },
      {
        '<leader>cgc',
        '<Cmd>CopilotChatCommitStaged<CR>',
        mode = 'n',
      },
    },
  },
  {
    'numToStr/FTerm.nvim',
    config = function()
      local FTerm = require('FTerm')
      FTerm.setup {
        -- Makes things a little bit more stable with tmux since it
        -- does not inherit the environment variables
        clear_env = true,
      }

      local lazydocker = FTerm:new {
        ft = 'fterm_lazydocker',
        cmd = 'lazydocker',
        clear_nv = true,
      }

      vim.api.nvim_create_user_command('LazyDockerToggle', function()
        lazydocker:toggle()
      end, {})

      local fterm1 = FTerm:new {
        cmd = vim.env.SHELL,
        ft = 'fterm_1',
        clear_env = true,
      }

      local fterm2 = FTerm:new {
        cmd = vim.env.SHELL,
        ft = 'fterm_2',
        clear_env = true,
      }

      vim.api.nvim_create_user_command('FTermToggle', FTerm.toggle, { bang = true })
      vim.api.nvim_create_user_command('FTerm1Toggle', function()
        fterm1:toggle()
      end, { bang = true })

      vim.api.nvim_create_user_command('FTerm2Toggle', function()
        fterm2:toggle()
      end, { bang = true })

      vim.api.nvim_create_user_command('FTermCloseAllExcept', function(command)
        if command.args == '1' then
          FTerm.close()
          fterm2:close()
        elseif command.args == '2' then
          FTerm.close()
          fterm1:close()
        else
          fterm1:close()
          fterm2:close()
        end
      end, {
        complete = function()
          return { '0', '1', '2' }
        end,
        nargs = '?',
      })
    end,
    cmd = {
      'FTermToggle',
      'FTerm1Toggle',
      'FTerm2Toggle',
      'LazyDockerToggle',
    },
    keys = {
      {
        '<M-e>',
        function()
          if vim.fn.mode() == 't' then
            vim.cmd('FTermCloseAllExcept 0')
          end
          require('FTerm').toggle()
        end,
        mode = { 'n', 't' },
      },
      {
        '<M-i>',
        function()
          if vim.fn.mode() == 't' then
            vim.cmd('FTermCloseAllExcept 1')
          end
          vim.cmd('FTerm1Toggle')
        end,
        mode = { 'n', 't' },
      },
      {
        '<M-o>',
        function()
          if vim.fn.mode() == 't' then
            vim.cmd('FTermCloseAllExcept 2')
          end
          vim.cmd('FTerm2Toggle')
        end,
        mode = { 'n', 't' },
      },
    },
  },
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle focus=true<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xq',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'folke/ts-comments.nvim',
    opts = {
      lang = {
        htmldjango = {
          '{# %s #}',
        },
      },
    },
  },
  {
    'andrewferrier/debugprint.nvim',
    event = { 'BufReadPost' },
    opts = {},
    version = '*',
  },
}
