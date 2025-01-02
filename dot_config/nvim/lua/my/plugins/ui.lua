return {
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        background = {
          light = 'latte',
          dark = 'frappe',
        },
        no_italic = false, -- Force  no italic
        no_bold = false,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
        transparent_background = false,
        custom_highlights = function(colors)
          return {
            StatuslineFilePrefix = { bg = colors.surface0, fg = colors.subtext0, style = { 'italic' } },
            StatuslineFileName = { bg = colors.surface0, fg = colors.text, style = { 'bold' } },
            StatusLineMode = { bg = colors.text, fg = colors.base },
            MiniFilesNormal = { bg = colors.none, fg = colors.text },
            FzfLuaNormal = { bg = colors.none },
          }
        end,
        integrations = {
          aerial = true,
          cmp = true,
          fzf = true,
          gitsigns = true,
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme('catppuccin')

      vim.api.nvim_create_user_command('CatppuccinToggleTransparent', function()
        local cat = require('catppuccin')
        -- Change the compile path so whenever we restart neovim, it won't use
        -- the old compiled file
        cat.options.compile_path = string.format('%s/tmp-catppuccin', vim.fn.stdpath('cache'))
        cat.options.transparent_background = not cat.options.transparent_background

        if cat.options.transparent_background then
          require('my.utils').info('enabled catppuccin.transparent_background', 'Toggle')
        else
          require('my.utils').warn('disabled catppuccin.transparent_background', 'Toggle')
        end

        cat.compile()
        vim.cmd.colorscheme(vim.g.colors_name)
      end, {})
    end,
  },
  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = { 'BufRead' },
    opts = {
      -- Copied from catppuccin theme recommendation
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    'hiphish/rainbow-delimiters.nvim',
    event = 'BufReadPost',
    config = function()
      local rainbow = require('rainbow-delimiters')
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = function(bufnr)
            -- Disabled for very large files, global strategy for large files,
            -- local strategy otherwise
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            if line_count > 10000 then
              return nil
            elseif line_count > 1000 then
              return rainbow.strategy['global']
            end

            return nil
          end,
        },
        highlight = {
          -- 'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          -- 'RainbowDelimiterOrange',
          -- 'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        enabled = false,
      },
    },
  },
  {
    'miversen33/sunglasses.nvim',
    event = 'UIEnter',
    dev = true,
    opts = {
      filter_type = 'NOSYNTAX',
      filter_percent = 0.35,
      excluded_filetypes = {
        'spellpopup',
        'fugitive',
        'gitcommit',
        'qf',
        'http',
        'text',
        'grug-far',
        'oil',
      },
      excluded_highlights = {
        'WinSeparator',
        { 'StatusLine*', glob = true },
        { 'User*', glob = true },
      },
    },
    config = function(_, opts)
      local sg = require('sunglasses')
      sg.setup(opts)
    end,
  },
}
