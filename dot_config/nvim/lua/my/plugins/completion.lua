vim.g.nvim_cmp_t_state = true
vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

vim.keymap.set('n', 'yoq', function()
  vim.g.nvim_cmp_t_state = not vim.g.nvim_cmp_t_state

  if vim.g.nvim_cmp_t_state then
    require('my.utils').info('enabled autocomplete', 'Toggle')
  else
    require('my.utils').warn('disabled autocomplete', 'Toggle')
  end
end, { desc = 'toggle autocomplete' })

local cmp_config = function()
  local cmp = require('cmp')

  cmp.setup {
    enabled = function()
      if vim.g.nvim_cmp_t_state and vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt' then
        return true
      end

      return false
    end,
    preselect = cmp.PreselectMode.None,
    view = {
      entries = {
        follow_cursor = true,
      },
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      {
        name = 'buffer',
        max_item_count = 10,
        option = {
          show_source = true,
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr)
              return vim.fn.buflisted(bufnr) == 1
            end, vim.api.nvim_list_bufs())
          end,
        },
      },
    },
    window = {
      documentation = cmp.config.window.bordered(),
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        require('cmp-under-comparator').under, -- for python
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    snippet = {
      expand = function(args)
        -- FIXME: There is a bug where highlights gets left behind
        -- IDK what caused this so.... using luasnip for now
        -- vim.snippet.expand(args.body)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- NOTE: C-n/C-p Insert behavior does not work well with snippets from LSP.
      -- Still considering whether it's worth keeping this or just use cmp.SelectBehavior.Select
      ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-g>'] = function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.open_docs()
        end
      end,
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Insert },
      ['<C-j>'] = cmp.mapping(function(fallback)
        if require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        else
          fallback()
        end
      end),
      ['<C-k>'] = cmp.mapping(function(fallback)
        if require('luasnip').jumpable(-1) then
          require('luasnip').jump(-1)
        else
          fallback()
        end
      end),
    },
    experimental = {
      ghost_text = {
        hl_group = 'CmpGhostText',
      },
    },
  }

  -- Setup filetype sources
  cmp.setup.filetype('html', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'rg', max_item_count = 10 },
      { name = 'buffer', max_item_count = 10 },
    }),
  })

  cmp.setup.filetype('markdown', {
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'mocword' },
      { name = 'rg', max_item_count = 10 },
      { name = 'buffer', max_item_count = 10 },
    },
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'mocword' },
      { name = 'rg', max_item_count = 10 },
    }, {
      { name = 'buffer', max_item_count = 10 },
    }),
  })

  cmp.setup.filetype('sql', {
    sources = cmp.config.sources {
      { name = 'vim-dadbod-completion' },
      { name = 'buffer', max_item_count = 10 },
    },
  })

  -- Following the vim philosophy keybindings
  -- @see `:h ins-completion`
  vim.keymap.set('i', '<C-x><C-o>', function()
    cmp.complete {
      config = {
        sources = {
          { name = 'nvim_lsp' },
        },
      },
    }
  end, { desc = 'LSP completion' })

  vim.keymap.set('i', '<C-x><C-s>', function()
    cmp.complete {
      config = {
        sources = {
          { name = 'luasnip' },
        },
      },
    }
  end, { desc = 'Snippet completion' })

  vim.keymap.set('i', '<C-x><C-]>', function()
    cmp.complete {
      config = {
        sources = {
          { name = 'tags', max_item_count = 10 },
        },
      },
    }
  end, { desc = 'ctags completion' })

  vim.keymap.set('i', '<C-x><C-x>', function()
    cmp.complete {
      config = {
        sources = {
          { name = 'rg', max_item_count = 10 },
        },
      },
    }
  end, { desc = 'ripgrep completion' })

  vim.keymap.set('i', '<C-x><C-y>', function()
    cmp.complete {
      config = {
        sources = {
          { name = 'cmp_yanky', kind_text = 'Clipboard' },
        },
      },
    }
  end, { desc = 'yanky completion' })

  vim.keymap.set('i', '<C-x><C-u>', function()
    cmp.complete {
      config = {
        sources = {
          { name = 'copilot' },
        },
      },
    }
  end, { desc = 'copilot (see :h i_CTRL-X_CTRL_U)' })

  vim.keymap.set('i', '<C-x><C-f>', function()
    cmp.complete {
      config = {
        sources = {
          {
            name = 'async_path',
            option = {
              trailing_slash = true,
            },
          },
        },
      },
    }
  end, { desc = 'Path completion (async)' })

  vim.keymap.set('i', '<C-x><C-l>', function()
    cmp.complete {
      config = {
        sources = {
          {
            name = 'mocword',
          },
        },
      },
    }
  end, { desc = 'Mocword' })
end

return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    config = cmp_config,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'lukas-reineke/cmp-rg',
      'lukas-reineke/cmp-under-comparator',
      'chrisgrieser/cmp_yanky',
      'yutkat/cmp-mocword',
      {
        'yujinyuz/cmp-async-path',
        dev = true,
      },
      {
        'zbirenbaum/copilot-cmp',
        enabled = false,
        config = true,
        dependencies = {
          'zbirenbaum/copilot.lua',
          opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
          },
        },
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    opts = {
      disable_filetype = { 'vim', 'markdown' },
      map_c_w = true,
      check_ts = true,
    },
  },
}
