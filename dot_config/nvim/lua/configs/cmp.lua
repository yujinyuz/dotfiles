local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then
  return
end

local has_luasnip, luasnip = pcall(require, 'luasnip')
local has_lspkind, lspkind = pcall(require, 'lspkind')

vim.g.nvim_cmp_t_state = true

local cmp_config = {
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
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'copilot' },
    {
      name = 'buffer',
      max_item_count = 10,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  }),
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
      if has_luasnip then
        luasnip.lsp_expand(args.body)
      end
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-g>'] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
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

if has_lspkind then
  cmp_config.formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      max_width = 50,
      showLabelDetails = true,
      symbol_map = { Copilot = '', Yank = '', Suggest = '󱈛', RG = '󰈙' },
      before = function(entry, vim_item)
        if entry.source.name == 'cmp_yanky' then
          vim_item.kind = 'Yank'
        elseif entry.source.name == 'mocword' then
          vim_item.kind = 'Suggest'
        elseif entry.source.name == 'rg' then
          vim_item.kind = 'RG'
        end
        return vim_item
      end,
    },
  }
end

cmp.setup(cmp_config)

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

-- Following the vim philosophy keybindings
-- @see `:h ins-completion`
vim.keymap.set('i', '<C-x><C-o>', function()
  cmp.complete {
    config = {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
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

vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'LspCodeLens', default = true })
