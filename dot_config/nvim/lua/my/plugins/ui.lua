return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe',
        background = {
          light = 'latte',
          dark = 'frappe',
        },
        no_italic = false, -- Force  no italic
        no_bold = false,
        term_colors = true,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            Folded = { bg = colors.surface1 }, -- Fix folded background when using transparent
            StatusLine = { bg = colors.surface0 },
            StatuslineFilePrefix = { bg = colors.surface0, fg = colors.subtext0 },
            StatuslineFileName = { bg = colors.surface0, fg = colors.text, style = { 'bold' } },
          }
        end,
        integrations = {
          aerial = true,
          cmp = true,
          mason = true,
          nvimtree = true,
          which_key = true,
          fidget = true,
          rainbow_delimiters = true,
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
        },
      }
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      wk.setup {
        show_help = false,
        key_labels = {
          ['<leader>'] = 'SPC',
          ['<CR>'] = 'RET',
          ['<TAB>'] = 'TAB',
        },
        window = { padding = { 0, 0, 0, 0 } },
        layout = { height = { min = 1, max = 10 } },
        triggers_blacklist = {
          c = { 'w', 'f', 'F' },
          n = { '`' },
        },
      }
      wk.register {
        ['<leader>c'] = { name = '+lsp' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>h'] = { name = '+hunk' },
        ['<leader>p'] = { name = '+pad' },
        ['<leader>q'] = { name = '+quit' },
        ['<leader>s'] = { name = '+search' },
        ['y'] = { name = '+yank' },
        ['yo'] = { name = '+switch on/off' },
      }
    end,
  },
  { 'kyazdani42/nvim-web-devicons', lazy = true },
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
            return rainbow.strategy['local']
          end,
        },
      }
    end,
  },
  {
    'levouh/tint.nvim',
    event = 'VeryLazy',
    opts = {
      tint = -5,
      saturation = 0,
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
        local buflisted = vim.api.nvim_get_option_value('buflisted', { buf = bufid })
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ''
        local diff_mode = vim.api.nvim_get_option_value('diff', { win = winid })

        -- Do not tint unlisted buffers since we don't really care about them
        if not buflisted then
          return true
        end

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == 'terminal' or floating or diff_mode
      end,
    },
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
}
